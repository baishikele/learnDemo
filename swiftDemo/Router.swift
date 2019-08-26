//
//  Router.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/21.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import URLNavigator

class Router: NSObject {

    static let shared = Router()
    
    private var navigator: NavigatorType = Navigator()

    override init() {
        super.init()
        
        setUpPages()
        setUpActions()
    }
    
    func open(url: String) -> Void {
        
        open(url: url, context: nil)
    }
    
    
    func open(url: String, context: Any?) -> Void {
        self.navigator.push(url, context: context, from: nil, animated: true)
    }
    
    func setUpPages() {
        
        self.navigator.register("jumeimall://mine"){(url, values, context) -> UIViewController? in
            
            
            print(url)
            print(values)
            print(context ?? "defult")

            
            return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigatorViewController")
        }
        
        self.navigator.register("abc") { (url, _, CONTEXT)  -> UIViewController? in
            
            return nil
        }
      
        
    }
    
    
    func setUpActions()  {
        
        self.navigator.handle("") { (url, vlues, context) -> Bool in
            
            
            return true
        }
    }
}
