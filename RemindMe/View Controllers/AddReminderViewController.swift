//
//  AddReminderViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class AddReminderViewController: MasterViewController {

    @IBOutlet weak var addTaskView:AddTaskView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    

    private func configure() {
        titleViewHolder.titleLabel.text = Constants.ReminderTitle
        titleViewHolder.dismissView = {
            self.navigationController?.popViewController(animated: true);
        }
    }
}
