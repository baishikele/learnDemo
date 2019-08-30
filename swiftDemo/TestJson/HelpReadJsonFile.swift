//
//  HelpReadJsonFile.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/30.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit

class HelpReadJsonFile: NSObject {

    static func readJsonFile()->Any?{
        
        let path = Bundle.main.path(forResource: "test1.json", ofType: nil)
        guard let path_ = path else {
            return nil
        }
        
        let url = URL(fileURLWithPath: path_)
        
        let data = try? Data.init(contentsOf: url)
        
        guard let data_ = data else {
            return nil
        }

        let dict = try? JSONSerialization.jsonObject(with: data_, options: JSONSerialization.ReadingOptions.mutableContainers)
        guard let dict_ = dict else{
            return nil
        }
        
        return dict_
        
    }
}
