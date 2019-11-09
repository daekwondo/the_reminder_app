//
//  PickerViewController.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 10/10/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    private var pickerType = CellType.category
    private var dataArray = [String]()
    private  var unitArray = [String]()
    private var pickerValue = Constants.EmptyString;
    private  var isPlural = false
    
    @IBOutlet private weak var datePicker:UIDatePicker!
    @IBOutlet private weak var picker:UIPickerView!
    @IBOutlet private weak var buttonHolder:UIView!
    @IBOutlet private weak var cancelButton:UIButton!
    @IBOutlet private weak var doneButton:UIButton!
    
    private var pickerDidSelect:((_ string:String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FontColor.clear
    }
    
    private func configureView() {
        buttonHolder.backgroundColor = FontColor.backGroundColor
        cancelButton.configureWith(title: Constants.Cancel, titleColor: FontColor.lightGrayColor, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero)
        doneButton.configureWith(title: Constants.Done, titleColor: FontColor.white, backgroundColor: FontColor.clear, cornerRadius: RadiusSize.Zero)
        
        var showDatePicker = false
        if pickerType == .startDate {
            showDatePicker = true
        }
        
        datePicker.isHidden = !showDatePicker
        picker.isHidden = showDatePicker
        
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
    }
    
    func showPicker(forTask task:Tasks, forType type:CellType, handle:@escaping ((String) -> Void)) {
        self.pickerType = type;
        self.pickerDidSelect = handle
        configureView()
        
        if pickerType == .startDate {
            let value = task.startDate
            datePicker.setDate(value, animated: true)
        }
        else if pickerType == .interval {
            let value = task.interval.toString(checkPlural: false)
            let temp = value.components(separatedBy: " ");
            let item = temp[0]
            let unit = temp[1]
            
            checkPlural(item)
            
            unitArray = Unit.fetchAll()
            dataArray = UnitManager.didChange(toUnit: task.interval.unit)
            
            guard let valueIndex = dataArray.firstIndex(of: item), let unitIndex = unitArray.firstIndex(of: unit) else {
                return
            }
            
            picker.selectRow(valueIndex, inComponent: 0, animated: true)
            picker.selectRow(unitIndex, inComponent: 1, animated: true)
        }
        else {
            var value:String = Constants.EmptyString;
            
            if pickerType == .category {
                dataArray = ReminderType.fetchAll()
                value = task.category.stringValue()
            }
            else if pickerType == .repeats {
                dataArray = [Constants.YES,Constants.NO]
                value = task.repeats ? Constants.YES : Constants.NO
            }
            
            guard let valueIndex = dataArray.firstIndex(of: value) else {
                return
            }
            
            picker.selectRow(valueIndex, inComponent: 0, animated: true)
        }
        
        picker.reloadAllComponents()
    }
    
    @IBAction private func didTapButton(_ sender:UIButton) {
        if sender == doneButton {
            if pickerType == .startDate {
                pickerValue = datePicker.date.toString()
            }
            else {
                let dataIndex = picker.selectedRow(inComponent: 0)
                pickerValue = dataArray[dataIndex]
                
                if pickerType == .interval {
                    let unitIndex = picker.selectedRow(inComponent: 1)
                    pickerValue = pickerValue + "," + unitArray[unitIndex]
                }
            }
            
            if let handler = pickerDidSelect, pickerValue.count > 0 {
                handler(pickerValue)
            }
        }
        dismiss(animated: true)
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerType == CellType.interval {
            return 2
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerType == CellType.interval && component == 1 {
            return unitArray.count
        }
        
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataArray[row]
        }
        
        var unit = unitArray[row]
        if isPlural {
            unit = unit + "s"
        }
        
        return unit;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerType == CellType.interval {
            if component == 1 {
                let unit = unitArray[row]
                dataArray = UnitManager.didChange(toUnit: Unit.convertToEnum(unit))
                pickerView.reloadComponent(0)
            }
            else if component == 0 {
                let value = dataArray[row]
                checkPlural(value)
                
                pickerView.reloadComponent(1)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    private func checkPlural(_ value:String) {
        if Int(value) ?? 0 > 1 {
            isPlural = true
        }
        else {
            isPlural = false
        }
    }
}
