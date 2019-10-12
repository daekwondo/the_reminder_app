//
//  Tasks.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/17/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

enum TaskType: String {
    case general = "general"
    case birthday = "birthday"
    case health = "health"
    case anniversay = "anniversay"
    case unknown = "unknown"
}

class Tasks: NSObject {
    
    let name:String
    let endDate:Date
    let category:TaskType
    let repeats:Bool
    let interval:TimeInterval
    let taskId:String?
    
    init(name:String, endDate:Date, category:TaskType = .general, repeats:Bool = false, interval:TimeInterval) {
        
        self.name = name
        self.endDate = endDate
        self.category = category
        self.repeats = repeats
        self.interval = interval
        self.taskId = nil
        
        super.init();
    }
}
