//
//  ReminderViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class ReminderViewController: MasterViewController {
    
    private var taskListInfo = [String:[Tasks]]()
    @IBOutlet weak var addViewHolder:AddView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        addViewHolder.alpha = 0;
        
        let identifiers = [CellIdentifier.EmptyTaskCell, CellIdentifier.TaskCell]
        for identifier in identifiers {
            tableView.registerIdentifier(identifier)
        }
        
        configure()
        
        DataManager.loadTasks() { (tasks) in
            self.showTaskList(list: tasks)
            self.handleAddViewVisible()
        }
    }
    
    private func addTask(_ task:Tasks) {
        NotificationManager.sharedInstance.configureNotification()
        NotificationManager.sharedInstance.scheduleNotification(forTask: task)
        
        addToTaskList(task)
        handleAddViewVisible()
    }
    
    //this category is the category of task if being deleted
    //this category is the category of task before being edited if being edited
    private func removeTask(_ task:Tasks, withPreviousKey key:String? = nil) {
        DataManager.delete(task)
        let category = key ?? task.category.stringValue()
        
        if var categoryInfo = taskListInfo[category], let index = categoryInfo.firstIndex(of: task) {
            categoryInfo.remove(at: index)
            if categoryInfo.count == 0 {
                taskListInfo.removeValue(forKey: category)
            }
            else {
                taskListInfo[category] = categoryInfo
            }
        }
    }
    
    private func addToTaskList(_ task:Tasks) {
        let category = task.category.stringValue()
        if var categoryInfo = taskListInfo[category] {
            if let index = categoryInfo.firstIndex(of: task) {
                categoryInfo.remove(at: index)
            }
            
            if categoryInfo.count == 0 {
                categoryInfo.append(task)
            }
            else {
                categoryInfo.insert(task, at: 0)
            }
            
            taskListInfo[category] = categoryInfo
        }
        else {
            taskListInfo[category] = [task]
        }
        
        tableView.reloadData()
    }
    
    func showTaskList(list:[Tasks]) {
        for task in list {
            addToTaskList(task)
        }
    }
    
    private func handleAddViewVisible() {
        var alpha:CGFloat = 1
        if isListEmpty() {
            alpha = 0
        }
        
        UIView.animate(withDuration:Duration.Thirty) {
            self.addViewHolder.alpha = alpha
        }
    }
    
    private func configure() {
        addViewHolder.handleAddTask = {
            self.showAddReminder()
        }
    }
    
    private func showAddReminder(forTask task:Tasks = Tasks(), taskStatus status:TaskStatus = .creating) {
        let category = task.category.stringValue()
        let addReminderVC = loadStory(StoryName.AddReminderVC) as! AddReminderViewController
        addReminderVC.showAddReminder(forTask: task, taskStatus:status ) { (editedTask,taskStatus) in
            if taskStatus == .viewing {
                return
            }
            else if taskStatus == .editing {
                self.removeTask(editedTask, withPreviousKey: category)
                DataManager.delete(editedTask);
            }
            
            DataManager.save(task)
            self.addTask(editedTask)
        }
        self.navigationController?.pushViewController(addReminderVC, animated: true)
    }
    
    private func checkIfPriorSectionsEmpty(section:Int) -> Bool {
        var isEmpty = true
        for num in 0 ..< section {
            isEmpty = isSectionEmpty(num)
            if !isEmpty {
                break
            }
        }
        
        return isEmpty
    }
    
    private func editTask(atIndexPath indexPath:IndexPath) {
        let task = getTask(atIndexPath: indexPath)
        showAddReminder(forTask: task, taskStatus: .editing)
    }
    
    private func deleteTask(atIndexPath indexPath:IndexPath) {
        let task = getTask(atIndexPath: indexPath)
        
        removeTask(task)
        
        if isListEmpty() {
            tableView.reloadData()
            handleAddViewVisible()
        }
        else {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    private func getTask(atIndexPath indexPath:IndexPath)->Tasks {
        let key = getKey(forSection: indexPath.section)
        let taskList = taskListInfo[key]!
        let task = taskList[indexPath.row]
        return task
    }
}

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func getKey(forSection section:Int) -> String {
        switch section {
            case 0:
                return ReminderType.Anniversary.stringValue()
            
            case 1:
                return ReminderType.Birthday.stringValue()
            
            case 2:
                return ReminderType.General.stringValue()
            
            case 3:
                return ReminderType.Health.stringValue()
        
            default:
                return Constants.EmptyString
        }
    }
    
    private func isListEmpty() -> Bool {
        var isEmpty = false
        if taskListInfo.count == 0 {
            isEmpty = true
        }
        
        return isEmpty
    }
        
    private func isSectionEmpty(_ section:Int) -> Bool {
        let key = getKey(forSection:section)
        
        if let taskInfo = taskListInfo[key] {
            return taskInfo.count == 0
        }
        
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isListEmpty() {
            return 1
        }
        
        return ReminderType.fetchAll().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isListEmpty() {
            return 1
        }
        
        let key = getKey(forSection:section)
        guard let taskList = taskListInfo[key] else {
            return 0
        }
        
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isListEmpty() {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.EmptyTaskCell, for: indexPath)
            return emptyCell
        }
        
        let task = getTask(atIndexPath: indexPath)
        let taskCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TaskCell, for: indexPath) as! TaskCell
        taskCell.configure(forTask: task)
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is EmptyTaskCell {
            let emptyCell = cell as! EmptyTaskCell
            emptyCell.didTapAdd = {
                self.showAddReminder()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSectionEmpty(section) {
            return nil
        }
        
        let key = getKey(forSection: section)
        let categorySection = view.loadXib(XibName.CategorySection) as! CategorySection
        
        var separatorColor = FontColor.grayColor
        var bgColor = FontColor.white
        var radius:CGFloat = 0.0;
        
        let isTopSection = checkIfPriorSectionsEmpty(section: section);
        if isTopSection {
            separatorColor = FontColor.clear
            radius = 20.0;
            bgColor = FontColor.backGroundColor
        }

        categorySection.contentViewHolder.roundCorners([.topLeft,.topRight], radius: radius)
        categorySection.backgroundColor = bgColor
        
        categorySection.separatorView.backgroundColor = separatorColor
        categorySection.categoryLabel.text = key
        categorySection.categoryImage.loadImage(imageName: key.lowercased())
        return categorySection
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return isListEmpty() ? nil : indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = getTask(atIndexPath: indexPath)
        showAddReminder(forTask: task, taskStatus: .viewing)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: Constants.Edit) { (action, view, completionHandler) in
            self.editTask(atIndexPath: indexPath)
            completionHandler(true)
        }
        
        action.image = UIImage(named: ImageName.Edit)
        action.backgroundColor = FontColor.white
        
        let actions = UISwipeActionsConfiguration(actions: [action])
        actions.performsFirstActionWithFullSwipe = false
        return actions
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: Constants.Delete) { (action, view, completionHandler) in
            self.deleteTask(atIndexPath: indexPath)
            completionHandler(true)
        }
        
        action.image = UIImage(named: ImageName.Delete)
        
        let actions = UISwipeActionsConfiguration(actions: [action])
        actions.performsFirstActionWithFullSwipe = false
        return actions
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSectionEmpty(section) {
            return 0
        }
        
        return 60;
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is EmptyTaskCell {
            let emptyCell = cell as! EmptyTaskCell
            emptyCell.didTapAdd = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isListEmpty() {
            return UIScreen.main.bounds.size.height - viewHolder.barHeight();
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
