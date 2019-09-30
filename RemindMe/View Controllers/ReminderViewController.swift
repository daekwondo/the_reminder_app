//
//  ReminderViewController.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class ReminderViewController: MasterViewController {
    
    @IBOutlet weak var addViewHolder:AddViewHolder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configure()
    }
    
    private func configure() {
        addViewHolder.handleAddTask = {
            self.showAddReminderView()
        }
    }
    
    private func showAddReminderView() {
        let addReminderVC = loadStory(StoryName.AddReminderVC) as! AddReminderViewController
        self.navigationController?.pushViewController(addReminderVC, animated: true)
    }
}
