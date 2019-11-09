//
//  Enums.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 11/6/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import Foundation

enum CellType:Int {
    case name = 0
    case category = 1
    case repeats = 2
    case startDate = 3
    case interval = 4
    case createReminder = 5
    
    func intValue() -> Int {
        return self.rawValue
    }
    
    static func convertToEnum(_ index:Int) -> CellType {
        guard let type = CellType(rawValue:index) else {
            assertionFailure("Unexpected Index Value")
            return name
        }
        
        return type
    }
}

enum Unit : String, CaseIterable {
    case Minute
    case Hour
    case Day
    case Week
    case Month
    
    func stringValue() -> String {
        return self.rawValue
    }
    
    static func convertToEnum(_ unitString:String) -> Unit {
        guard let unit = Unit(rawValue:unitString) else {
            assertionFailure("Unexpected Enum Value")
            return .Minute
        }
        
        return unit
    }
    
    static func fetchAll() -> [String] {
        Unit.allCases.map { $0.rawValue }
    }
    
    
    static func calculateInterval(_ unit:Unit) -> Double {
        switch unit {
        case .Minute:
            return  60.0
            
        case .Hour:
            return 60 * Unit.calculateInterval(.Minute)
            
        case .Day:
            return 24 * Unit.calculateInterval(.Hour)
            
        case .Week:
            return 7 * Unit.calculateInterval(.Day)
            
        case .Month:
            return 30 * Unit.calculateInterval(.Week)
        }
    }
}

enum ReminderType : String, CaseIterable {
    
    case Anniversary
    case Birthday
    case General
    case Health
    
    
    func stringValue() -> String {
        return self.rawValue
    }
    
    static func fetchAll() -> [String] {
        ReminderType .allCases.map { $0.rawValue }
    }
    
    static func convertToEnum(_ unitString:String) -> ReminderType {
        guard let category = ReminderType(rawValue:unitString) else {
            assertionFailure("Unexpected Enum Value")
            return .General;
        }
        
        return category;
    }
}


struct UnitManager {
    static func didChange(toUnit unit:Unit) -> [String] {
        switch unit {
        case .Minute:
            return numbers(upto:60)
        case .Hour:
            return numbers(upto:24)
        case .Day:
            return numbers(upto:30)
        case .Week:
            return numbers(upto:7)
        case .Month:
            return numbers(upto:12)
        }
    }
    
    private static func numbers(upto max:Int) -> [String] {
        var numberArray = [String]()
        
        for i in 1..<max {
            numberArray.append("\(i)")
        }
        
        return numberArray
    }
}

struct ReminderInterval {
    let  value:String
    let  unit:Unit
    init(value:String, unit:Unit) {
        self.value = value
        self.unit = unit
    }
    
    func caluclateInterval() -> Double {
        return (Double(self.value) ?? 0) * Unit.calculateInterval(self.unit)
    }
    
    func toString(checkPlural check:Bool) -> String {
        var unit = self.unit.stringValue()
        if check {
            if Int(value) ?? 0 > 1 {
                unit = unit + "s"
            }
            return value + " " + unit
        }
        
        return value + " " + unit
    }
}
