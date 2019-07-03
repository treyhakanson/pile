//
//  Configuration.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/26/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit
import CoreData

struct TimerConfig {

    var intervalTime: Int
    var breakTime: Int
    var sets: Int
    var context: NSManagedObject?
    
    init(intervalTime: Int, breakTime: Int, sets: Int) {
        self.intervalTime = intervalTime
        self.breakTime = breakTime
        self.sets = sets
    }
    
    init?(context: NSManagedObject) {
        guard let intervalTime = context.value(forKey: "intervalTime") as? Int else { return nil }
        guard let breakTime = context.value(forKey: "breakTime") as? Int else { return nil }
        guard let sets = context.value(forKey: "sets") as? Int else { return nil }
        
        self.intervalTime = intervalTime
        self.breakTime = breakTime
        self.sets = sets
        self.context = context
    }
    
    func toString() -> String {
        let intervalTime = Utils.toDisplayTime(seconds: self.intervalTime)
        let breakTime = Utils.toDisplayTime(seconds: self.breakTime)
        
        return "\(intervalTime)/\(breakTime)/\(sets)"
    }
    
    func save() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TimerConfigModel", in: managedContext)!
        let configuration = NSManagedObject(entity: entity, insertInto: managedContext)
        
        configuration.setValue(self.intervalTime, forKey: "intervalTime")
        configuration.setValue(self.breakTime, forKey: "breakTime")
        configuration.setValue(self.sets, forKey: "sets")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            throw error
        }
    }
    
}
