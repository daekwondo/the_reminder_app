//
//  AddReminderViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

enum TaskStatus:Int {
    case creating = 1
    case viewing = 2
    case editing = 3
}

class AddReminderViewController: MasterViewController {
    
    private var addTask:((_ task:Tasks, _ taskStatus:TaskStatus)->Void)!
    private var task = Tasks();
    private var taskStatus:TaskStatus = .creating
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifiers = [CellIdentifier.TextFieldCell, CellIdentifier.TextLabelCell, CellIdentifier.ButtonCell]
        for identifier in identifiers {
            tableView.registerIdentifier(identifier)
        }
        
        configure()
    }
    

    private func configure() {
        titleViewHolder.titleLabel.text = Constants.AddReminder
        titleViewHolder.configureEditButton(forStatus: taskStatus)
        titleViewHolder.dismissView = {
            self.dismissView()
        }
        
        titleViewHolder.editAction = {
            self.taskStatus = .editing
            self.titleViewHolder.configureEditButton(forStatus: self.taskStatus)
            let nameIndexPath = IndexPath(item: CellType.name.intValue(), section: 0);
            self.tableView.reloadRows(at: [nameIndexPath], with: .fade)
            
            let buttonIndexPath = IndexPath(item: CellType.createReminder.intValue(), section: 0);
            self.tableView.reloadRows(at: [buttonIndexPath], with: .fade)
        }
    }
    
    func showAddReminder(forTask task:Tasks, taskStatus status:TaskStatus, handle:@escaping ((Tasks,TaskStatus) -> Void)) {
        addTask = handle
        taskStatus = status
        self.task = task
    }
    
    private func addTaskToList() {
        if task.name.count == 0 {
            self.view.showToastMessage("Task title cannot be empty.")
            return
        }
        
        if let handler = addTask {
            handler(task,taskStatus)
        }
        
        self.dismissView()
    }
    
    private func dismissView() {
        self.navigationController?.popViewController(animated: true);
    }
    
    private func showPickerView(forType type:CellType) {
        view.endEditing(true)
        let pickerVC = loadStory(StoryName.PickerVC) as! PickerViewController
        modalPresentationStyle = .overCurrentContext
        present(pickerVC, animated: true, completion: nil)
        
        pickerVC.showPicker(forTask: task, forType: type) { value in

            switch type {
                case .name:
                    self.task.name = value
                    break

                case .category:
                    self.task.category = ReminderType.convertToEnum(value)
                    break

                case .startDate:
                    self.task.startDate = value.toDate()
                    break

                case .interval:
                    let temp = value.components(separatedBy: ",");
                    if temp.count == 2 {
                        let rem = ReminderInterval(value: temp[0], unit: Unit.convertToEnum(temp[1]))
                        self.task.interval = rem
                    }

                    break

                case .repeats:
                    if value == Constants.YES {
                        self.task.repeats = true
                    }
                    else {
                        self.task.repeats = false
                    }
                    break
            case .createReminder:
                break
            }

            self.tableView.reloadData()
        }
    }
}

extension AddReminderViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if index == CellType.name.intValue() {
            if taskStatus == .viewing {
                return configureCell(atIndex: indexPath)
            }
            
            return configureReminderTitle(atIndex: indexPath)
        }
        else if index == CellType.createReminder.intValue() {
            return configureButtonCell(atIndex: indexPath)
        }
        
        return configureCell(atIndex: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == CellType.name.intValue() {
            cell.contentView.roundCorners([.topLeft,.topRight], radius: 20)
            cell.backgroundColor = FontColor.backGroundColor
        }
        else {
            cell.contentView.roundCorners([.topLeft,.topRight], radius: 0)
            cell.backgroundColor = FontColor.white
        }
        
        if cell is TextFieldCell {
            let textFieldCell = cell as! TextFieldCell
            textFieldCell.updateText = { text in
                self.task.name = text;
            }
        }
        else if cell is ButtonCell {
            let buttonCell = cell as! ButtonCell
            if taskStatus == .editing {
                buttonCell.createButton.setTitle(Constants.UpdateReminder, for: .normal)
            }
            else if taskStatus == .creating{
                buttonCell.createButton.setTitle(Constants.CreateReminder, for: .normal)
            }
            else {
                buttonCell.createButton.setTitle(Constants.Done, for: .normal)
            }
            
            buttonCell.didTapCreateReminder = {
                self.view.endEditing(true)
                self.addTaskToList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is TextFieldCell {
            let textFieldCell = cell as! TextFieldCell
            textFieldCell.updateText = nil
        }
        else if cell is ButtonCell {
            let buttonCell = cell as! ButtonCell
            buttonCell.didTapCreateReminder = nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index == CellType.name.intValue() || index == CellType.createReminder.intValue() || taskStatus == .viewing {
            return
        }
        
        if ((task.category == .Anniversary || task.category == .Birthday) && (index == CellType.interval.intValue())) {
            self.view.showToastMessage("Cannot Edit Interval for Anniversary and Birthday.")
            return;
        }
        
        let cellType = CellType.convertToEnum(index)
        OperationQueue.main.addOperation {
            self.showPickerView(forType: cellType)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK : Configure Cells
    
    private func configureButtonCell(atIndex indexPath:IndexPath) -> ButtonCell {
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ButtonCell, for: indexPath) as! ButtonCell
        
        return buttonCell
    }
    
    private func configureReminderTitle(atIndex indexPath:IndexPath) -> TextFieldCell {
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TextFieldCell, for: indexPath) as! TextFieldCell
        textFieldCell.titleLabel.text = Constants.ReminderTitle
        textFieldCell.nameField.placeholder = Constants.ReminderTitle
        textFieldCell.nameField.text = task.name
        return textFieldCell
    }
    
    private func configureCell(atIndex indexPath:IndexPath) -> TextLabelCell {
        
        let textLabelCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TextLabelCell, for: indexPath) as! TextLabelCell
        
        let index = indexPath.row
        let cellType = CellType.convertToEnum(index)
        switch cellType {
            case .name:
                textLabelCell.titleLabel.text = Constants.ReminderTitle
                textLabelCell.detailLabel.text = task.name
                break
            
            case .category:
                textLabelCell.titleLabel.text = Constants.ReminderType
                textLabelCell.detailLabel.text = task.category.stringValue()
                break
            
            case .repeats:
                textLabelCell.titleLabel.text = Constants.RepeatReminder
                if task.repeats {
                    textLabelCell.detailLabel.text = Constants.YES
                }
                else {
                    textLabelCell.detailLabel.text = Constants.NO
                }
                break
            
            case .startDate:
                textLabelCell.titleLabel.text = Constants.ReminderStartDate
                textLabelCell.detailLabel.text = task.startDate.toString()
                break
            
            case .interval:
                textLabelCell.titleLabel.text = Constants.ReminderInterval
                
                if task.category == .Anniversary || task.category == .Birthday {
                    textLabelCell.detailLabel.text = Constants.Yearly;
                }
                else {
                    textLabelCell.detailLabel.text = task.interval.toString(checkPlural: true);
                }
                break
            default:
                break
        }
        
        return textLabelCell
    }
}

