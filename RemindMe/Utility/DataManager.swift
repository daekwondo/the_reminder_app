//
//  DataManager.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/19/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    // MARK: - Save Tasks
    class func save(_ task:Tasks, saveHandler:(()->Void)? = nil) {
        let context = fetchContext();
        let entityReminder = NSEntityDescription.entity(forEntityName: Entity.Reminders, in: context)
        let reminder = NSManagedObject(entity: entityReminder!, insertInto: context)
        let objectId = fetchId(from: reminder.objectID)
        
        reminder.setValue(task.name, forKey: Constants.Name)
        reminder.setValue(task.category.stringValue(), forKey: Constants.Category)
        reminder.setValue(task.interval.toString(checkPlural: false), forKey: Constants.Interval)
        reminder.setValue(task.repeats, forKey: Constants.Repeats)
        reminder.setValue(task.startDate.toString(), forKey: Constants.StartDate)
        reminder.setValue(objectId, forKey: Constants.TaskId)
        task.taskId = objectId
        print(objectId)
        saveContext()
        
        if let handler =  saveHandler {
            handler()
        }
    }
    
    // MARK: - Load Tasks
    class func loadTasks(forType type:ReminderType? = nil, loadHandler:(([Tasks])->Void)? = nil) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.Reminders)
        
        if let category = type {
            request.predicate = NSPredicate(format: "%@ = %@", Constants.Category,category.stringValue())
        }
        
        request.returnsObjectsAsFaults = false
        
        do {
            let context = fetchContext();
            let reminders = try context.fetch(request) as! [NSManagedObject]
            
            var tasks = [Tasks]()
            for reminder in reminders {
                let task = format(reminder)
                tasks.append(task)
            }
        
            if let handler =  loadHandler {
                handler(tasks)
            }
            
        } catch {
            print("Failed")
        }
    }
    
    class func delete(_ task:Tasks) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Entity.Reminders)
        fetchRequest.predicate = NSPredicate(format: "taskId ==[c] %@",task.taskId)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let context = fetchContext()
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    private class func fetchId(from object:NSManagedObjectID) -> String {
        let objectId = object.uriRepresentation().absoluteString
        return objectId.replacingOccurrences(of: "x-coredata:///Reminders/", with: "")
    }
    
    class private func format(_ reminder:NSManagedObject) -> Tasks {
        let name = reminder.value(forKey: Constants.Name) as! String
        let category = reminder.value(forKey: Constants.Category) as!String
        let interval = reminder.value(forKey: Constants.Interval) as!String
        let repeats = reminder.value(forKey: Constants.Repeats) as! Bool
        let startDate = reminder.value(forKey: Constants.StartDate) as!String
        let taskId = reminder.value(forKey: Constants.TaskId) as!String
        
        let intervals = interval.components(separatedBy: " ")
        let reminderInterval = ReminderInterval(value: intervals[0], unit: Unit.convertToEnum(intervals[1]))
        
        let task = Tasks(name: name, startDate: startDate.toDate(), category: ReminderType.convertToEnum(category), repeats: repeats, interval: reminderInterval)
        task.taskId = taskId
        
        print(taskId)
        return task
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RemindMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    static func fetchContext() -> NSManagedObjectContext {
        return DataManager.sharedInstance.persistentContainer.viewContext;
    }
    
    class func saveContext () {
        let context = fetchContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
