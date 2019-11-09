//
//  Tasks.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

 

class Tasks: NSObject {
    
    var name:String
    var startDate:Date
    var category:ReminderType
    var repeats:Bool
    var interval:ReminderInterval
    var taskId:String = "-1";
    
    init(name:String, startDate:Date, category:ReminderType, repeats:Bool, interval:ReminderInterval) {
        
        self.name = name
        self.startDate = startDate
        self.category = category
        self.repeats = repeats
        self.interval = interval
        
        super.init();
    }
    
    convenience override init() {
        let rem = ReminderInterval(value: "8", unit: Unit.Hour);
        self.init(name: Constants.EmptyString, startDate: Date(), category: .General, repeats: false, interval: rem);
    }
}
