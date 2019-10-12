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
        
        addTaskView.showPicker = { type in
            self.showPickerView(forType: type)
        }
    }
    
    private func showPickerView(forType type:CellType) {
        let pickerVC = loadStory(StoryName.PickerVC) as! PickerViewController
        pickerVC.pickerType = type
        modalPresentationStyle = .overCurrentContext
        present(pickerVC, animated: true, completion: nil)
    }
}
