//
//  ReminderViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class ReminderViewController: MasterViewController {
    
    private var dataArray = [Tasks]()
    
    @IBOutlet weak var addViewHolder:AddView!
    @IBOutlet weak var taskListView:TaskListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        addViewHolder.alpha = 0;
        
        configure()
        handleAddViewVisible()
        
        DataManager.loadTasks(forType: .unknown) { (tasks) in
            self.dataArray = tasks
            self.taskListView.showTaskList(list: tasks)
        }
    }
    
    private func handleAddViewVisible() {
        var alpha:CGFloat = 1
        if self.dataArray.count == 0 {
            alpha = 0
        }
        
        UIView.animate(withDuration:Duration.Thirty) {
            self.addViewHolder.alpha = alpha
        }
    }
    
    private func configure() {
        addViewHolder.handleAddTask = {
            self.showAddReminderView()
        }
        
        taskListView.addTask = {
            NotificationManager.sharedInstance.configureNotification()
            NotificationManager.sharedInstance.scheduleNotification(notificationType: "This is test")
            self.showAddReminderView()
        }
    }
    
    private func showAddReminderView() {
        let addReminderVC = loadStory(StoryName.AddReminderVC) as! AddReminderViewController
        self.navigationController?.pushViewController(addReminderVC, animated: true)
    }
}
