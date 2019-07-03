//
//  ViewController.swift
//  Core Data Demo
//
//  Created by David Hakanson on 1/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        newUser.setValue("Trey", forKey: "username")
        newUser.setValue("Zes2aw01", forKey: "password")
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print(result.valueForKey("username")!)
                    print(result.valueForKey("password")!)
                }
            }
        } catch {
            print("Error")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

