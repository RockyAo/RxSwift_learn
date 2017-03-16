//
//  Contructor.swift
//  03-BindTableView
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

struct Contributor {
    
    let name:String
    
    let id:String
    
    init(name:String,id:String) {
        
        self.name = name
        self.id = id
    }
    
}

extension Contributor:CustomStringConvertible{
    
    var description: String{
    
        return "\(name) and id :\(id)"
    }
}
