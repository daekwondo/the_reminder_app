//
//  AddTaskView.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/19/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

enum CellType:Int {
    case name = 0
    case category = 1
    case repeats = 2
    case endDate = 3
    case interval = 4
}

class AddTaskView: ListView {
    
    var taskName:String = Constants.EmptyString;
    var category:TaskType = .general;
    var repeats:Bool = false;
    var endDate:Date = Date();
    var interval:TimeInterval = 0;

    override func awakeFromNib() {
        let identifiers = [CellIdentifier.TextFieldCell, CellIdentifier.TextLabelCell]
        for identifier in identifiers {
            tableView.registerIdentifier(identifier)
        }
        super .awakeFromNib()
    }
}

extension AddTaskView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if index == CellType.name.rawValue {
            return configureReminderTitle(atIndex: indexPath)
        }
        
        return configureCell(atIndex: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == CellType.name.rawValue {
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
                print(text);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is TextFieldCell {
            let textFieldCell = cell as! TextFieldCell
            textFieldCell.updateText = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK : Configure Cells
    private func configureReminderTitle(atIndex indexPath:IndexPath) -> TextFieldCell {
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TextFieldCell, for: indexPath) as! TextFieldCell
        textFieldCell.titleLabel.text = Constants.ReminderTitle
        textFieldCell.nameField.placeholder = Constants.EnterReminderTitle
        return textFieldCell
    }
    
    private func configureCell(atIndex indexPath:IndexPath) -> TextLabelCell {
        let textLabelCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TextLabelCell, for: indexPath) as! TextLabelCell
        textLabelCell.titleLabel.text = Constants.ReminderTitle
        textLabelCell.detailLabel.text = Constants.EnterReminderTitle
        return textLabelCell
    }
}
