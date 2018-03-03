//
//  ViewController.swift
//  Example
//
//  Created by Amr Omran on 03/03/2018.
//  Copyright © 2018 Amr Omran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reachability = Reachability()!
   
    var batteryLevel: Float{
        return UIDevice.current.batteryLevel * 100
    }
    
    var batteryState: UIDeviceBatteryState{
        return UIDevice.current.batteryState
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetDidChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("Could not start notifier:\(error)")
        }
      

    }
    
    
    @objc func internetDidChanged(notification: Notification){
        if (reachability.connection != .none){
            switch reachability.connection{
            case .wifi:
                print("Wifi")
            case .cellular:
                print("Mobile Data")
            case .none:
                print("none")
            }
        }else{
            print("No Internet Connection")
        }
    }
    
    
    @objc func batteryLevelDidChange(notification: Notification){
        print(batteryLevel)
    }
    
    
    @objc func batteryStateDidChange (notification: Notification) {
        switch batteryState {
        case .unplugged:
            print("unplugged")
        case .unknown:
            print("not charging")
        case .charging:
            print("charging")
        case .full:
            print("full")
        }
    }
    
    
}

