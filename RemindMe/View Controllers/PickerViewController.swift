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
    var dataArray = [String]()
    var unitArray = [String]()
    
    @IBOutlet private weak var datePicker:UIDatePicker!
    @IBOutlet private weak var picker:UIPickerView!
    @IBOutlet private weak var buttonHolder:UIView!
    @IBOutlet private weak var cancelButton:UIButton!
    @IBOutlet private weak var doneButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FontColor.clear
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePicker()
    }
    
    private func configureView() {
        buttonHolder.backgroundColor = FontColor.backGroundColor
        cancelButton.configureWith(title: Constants.Cancel, titleColor: FontColor.lightGrayColor, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero)
        doneButton.configureWith(title: Constants.Done, titleColor: FontColor.white, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero)
        
        var showDatePicker = false
        if pickerType == .endDate {
            showDatePicker = true
        }
        
        datePicker.isHidden = !showDatePicker
        picker.isHidden = showDatePicker
        
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
    }
    
    @IBAction private func didTapButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func configurePicker() {
        if pickerType == CellType.category {
            dataArray = ["Anniversary","Birthday","General","Health"]
        }
        else if pickerType == CellType.repeats {
            dataArray = ["Yes","No"]
        }
        else if pickerType == CellType.interval {
            dataArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
            unitArray = ["Hour","Day","Week","Month","Year"]
        }
        picker.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerType == CellType.repeats || pickerType == CellType.category {
            return 1
        }
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataArray.count
        }
        
        return unitArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataArray[row]
        }
        
        return unitArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
}
