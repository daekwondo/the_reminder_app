//
//  AddReminderViewController.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class AddReminderViewController: MasterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    

    private func configure() {
        titleViewHolder.dismissView = {
            self.navigationController?.popViewController(animated: true);
        }
    }

}
