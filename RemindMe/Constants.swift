//
//  Constants.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit
import Hue

struct FontName {
    static let OpenSansRegular  = "OpenSans-Regular"
    static let OpenSansLight    = "OpenSans-Light"
    static let OpenSansSemiBold = "OpenSans-SemiBold"
    static let OpenSansBold     = "OpenSans-Bold"
}

struct FontSize {
    static let Ten:CGFloat      = 10
    static let Twelve:CGFloat   = 12
    static let Fourteen:CGFloat = 14
    static let Sixteen:CGFloat  = 16
    static let Eighteen:CGFloat = 18
    static let Twenty:CGFloat   = 20
}

struct RadiusSize {
    static let Zero:CGFloat     = 0
    static let Five:CGFloat     = 5
    static let Ten:CGFloat      = 10
    static let Fifteen:CGFloat  = 15
    static let Twenty:CGFloat   = 20
}

struct FontColor {
    static let white            = UIColor.white
    static let clear            = UIColor.clear
    static let darkBlue         = UIColor(hex: "#12498C")
    static let red              = UIColor.red
    static let green            = UIColor(hex: "#A5CF4E")
    static let backGroundColor  = UIColor(hex: "#3B5998")
    static let lightGrayColor   = UIColor(hex: "#D3D3D3")
    static let grayColor        = UIColor.gray
    static let black            = UIColor(hex: "#000000")
    static let borderColor      = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.05)
}

struct ImageName {
    static let Add = "add"
    static let Back = "back"
    static let Edit = "edit"
    static let Delete = "delete"
}

struct Duration {
    static let Thirty:TimeInterval = 0.30
    static let Sixty:TimeInterval = 0.60
}


struct StoryName {
    static let ReminderVC = "ReminderVC"
    static let AddReminderVC = "AddReminderVC"
    static let PickerVC = "PickerVC"
}

struct XibName {
    static let CategorySection = "CategorySection"
}

struct CellIdentifier {
    static let TaskCell = "TaskCell"
    static let EmptyTaskCell = "EmptyTaskCell"
    static let TextFieldCell = "TextFieldCell"
    static let TextLabelCell = "TextLabelCell"
    static let ButtonCell = "ButtonCell"
}

struct Entity {
    static let Reminders = "Reminders"
}

struct Constants {
    static let AddTask = "Add Task"
    static let ReminderTitle = "Title"
    static let AddReminder = "Add Reminder"
    
    static let ReminderType = "Reminder Category"
    
    static let RepeatReminder = "Repeat Reminder"
    
    static let ReminderStartDate = "Start Date"
    
    static let Yearly = "Yearly"
    
    static let ReminderInterval = "Interval"
    
    static let RemindMe = "Remind Me"
    static let EmptyString = ""
    
    static let Done = "DONE"
    static let Cancel = "CANCEL"
    
    static let YES = "YES"
    static let NO = "NO"
    
    static let CreateReminder = "Create Reminder"
    static let UpdateReminder = "Update Reminder"
    
    static let Edit = "Edit"
    static let Delete = "Delete"
    
    static let Name = "name"
    static let Category = "category"
    static let Interval = "interval"
    static let Repeats = "repeats"
    static let StartDate = "startDate"
    static let TaskId = "taskId"
    
}


