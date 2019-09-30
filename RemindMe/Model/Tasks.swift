//
//  Tasks.swift
//  RemindMe
//
//  Created by Santosh Bista on 9/17/19.
//  Copyright © 2019 Santosh Bista. All rights reserved.
//

import UIKit

enum TaskType: Int {
    case general = 1
    case birthday = 2
    case health = 3
    case anniversay = 4
}

class Tasks: NSObject {
    
    let name:String
    let endDate:Date
    let category:TaskType
    let repeats:Bool
    let interval:TimeInterval
    
    init(name:String, endDate:Date, category:TaskType = .general, repeats:Bool = false, interval:TimeInterval) {
        
        self.name = name
        self.endDate = endDate
        self.category = category
        self.repeats = repeats
        self.interval = interval
        
        super.init();
    }
}
