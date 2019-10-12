//
//  PickerViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 10/10/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    var pickerType = CellType.category
    
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var picker:UIPickerView!
    @IBOutlet weak var buttonHolder:UIPickerView!
    @IBOutlet weak var cancelButton:UIPickerView!
    @IBOutlet weak var doneButton:UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func configureView() {
        
    }

}
