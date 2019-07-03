//
//  AppDelegate.swift
//  WalletTracker
//
//  Created by David Hakanson on 10/21/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

let placesAPI = PlacesAPI()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // start updating location as soon as application launches
        locationManager.startUpdatingLocation()
        
        // get places
//        placesAPI.getPlaces()
        
        // Custom statubar
        UIApplication.shared.isStatusBarHidden = false
        (UIApplication.shared.value(forKey: "statusBar") as! UIView).backgroundColor = ColorUtils.MAIN
        
        // schedule notifications
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { (granted, error) -> Void in
            if !granted {
                print("Permission not given to send notifications")
            }
        }
        
        // example notification
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy some milk"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifier = "WalletTrackerAlert"
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
        
        return true
    }
    

}

extension AppDelegate: CLLocationManagerDelegate {
    
    // for when the location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if locations is empty, do nothing
        guard let location = locations.last else { return }
    }
    
    // for when a boundary is entered (maybe will use, would be better to do it with boundaries to
    // avoid over notifying the user)
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    // for when a boundary is exited (maybe will use, would be better to do it with boundaries to
    // avoid over notifying the user)
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    
}

