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
}

struct ImageName {
    static let Add = "add"
    static let Back = "back"
}

struct Duration {
    static let Thirty:TimeInterval = 30
    static let Sixty:TimeInterval = 60
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
}

struct Entity {
    static let Reminders = "Reminders"
}

struct Constants {
    static let AddTask = "Add Task"
    static let EnterReminderTitle = "Enter Reminder Title"
    static let ReminderTitle = "Reminder Title"
    
    static let EnterReminderType = "Choose Reminder Category"
    static let ReminderType = "Reminder Category"
    
    static let RepeatReminder = "Repeat Reminder"
    
    static let EnterReminderEndDate = "Choose Reminder End Date"
    static let ReminderEndDate = "Reminder End Date"
    
    static let EnterReminderInterval = "Enter Reminder Interval"
    static let ReminderInterval = "Reminder Interval"
    
    static let RemindMe = "Remind Me"
    static let AddReminder = "Add Reminder"
    static let EmptyString = ""
}


