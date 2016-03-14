//
//  AppDelegate.swift
//  SwiftBackgroundRun
//
//  Created by Enkhjargal Gansukh on 1/25/16.
//  Copyright © 2016 Enkhjargal Gansukh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    var myTask: UIBackgroundTaskIdentifier = 0
    var myTimer: NSTimer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if checkSupportMultiTaskDevice() == false{
            return
        }
        startRun()
//        myTask = application.beginBackgroundTaskWithName("myTask1", expirationHandler: {
//            [weak self] in
//            self!.endRun()
//        })
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        self.endRun()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func startRun(){
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkBackgroundTime", userInfo: nil, repeats: true)
    }
    
    func endRun(){
        let main_q = dispatch_get_main_queue()
        dispatch_async(main_q, {
            [weak self] in
            self!.myTimer?.invalidate()
            self!.myTimer = nil
            UIApplication.sharedApplication().endBackgroundTask(self!.myTask)
            self!.myTask = UIBackgroundTaskInvalid
        })
    }
    
    func checkBackgroundTime(){
        let backgroundTime = UIApplication.sharedApplication().backgroundTimeRemaining
        if backgroundTime  != 0.0{
            print("backgroundTime: \(backgroundTime)")
        }
    }
    
    func checkSupportMultiTaskDevice()->Bool{
        return UIDevice.currentDevice().multitaskingSupported
    }


}

