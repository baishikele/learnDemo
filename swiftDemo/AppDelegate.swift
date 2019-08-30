//
//  AppDelegate.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/14.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import HandyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let hasShow = UserDefaults.standard.value(forKey: "publishLawAlertShowKey") as? Bool ?? false

        print(hasShow)
        
        
        UserDefaults.standard.set(true, forKey: "publishLawAlertShowKey")
        UserDefaults.standard.synchronize()
        
        
        testHandyJson()

        return true
    }

    func testHandyJson() -> Void {
        
        let dict = HelpReadJsonFile.readJsonFile() as? [String: Any]
        if let model = GetUserCfgModel.deserialize(from: dict){
            print(model.data.video_cfg?.video_max_second)
        }

    }
    
    func testProtocel() -> Void {
        let ob = "{\"name\":\"Hally\",\"age\":2}".toObject(UserInfo.self)
        
        print(ob?.name ?? "default")
        
        let obString = ob?.toString()
        
        print(obString ?? "default")
        
        
        
        let data = Data(bytes: [0x2,0x33,0x54,0x78,0x1,0x2d,0x3a,0x5b,0x1,0x2d,0x3a,0x5b,0x1,0x2d,0x3a,0x5b])
        let color = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        data.pq.toHex()
        color.pq.blue()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

