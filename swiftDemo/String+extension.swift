//
//  String+extension.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/21.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit

extension String {
   
    func toObject<T>(_ : T.Type) -> T? where T: Codable {
        
        guard let data = self.data(using: .utf8) else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

protocol aProtocol: Codable {
    
}

extension aProtocol where Self:NSObject{
    
    func toString() -> String {
        
        let data = try? JSONEncoder().encode(self)
        guard let da = data else { return "" }
        guard let st = String.init(data: da, encoding: .utf8) else { return "" }
        return st
    }
}

//extension Codable{
//
//}

