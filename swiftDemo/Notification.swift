//
//  Notification.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/22.
//  Copyright © 2019 tanghuan. All rights reserved.
//

let notiName = "noti.name.t"

import UIKit

class Notification: NSObject {

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNotification), name: NSNotification.Name(notiName), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addSystemNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("haha"), object: nil)
    }
    
    @objc
    func addNotification(noti: Notification) -> Void {
        
        print(noti)
    }
    
    @objc
    func addSystemNotification(noti: Notification) -> Void {
        
        print(noti)
    }
}
