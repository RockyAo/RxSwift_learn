//
//  Protocol.swift
//  06-LoginDemo
//
//  Created by Rocky on 2017/3/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum Result{

    case ok(message:String)
    case empty
    case faild(message:String)
}

extension Result{

    var textColor:UIColor{
        
        switch self {
        case .ok:
            return UIColor(colorLiteralRed: 138/255.0, green: 221/255.0, blue: 109/255.0, alpha: 1)
        case .empty:
            return UIColor.blue
        case .faild:
            return UIColor.orange
        }
    }
    
    
    var description:String{
    
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .faild(message):
            return message
        }

    }
    
    var isValidation:Bool{
    
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}


extension Reactive where Base:UILabel{

    var validationResult:UIBindingObserver<Base,Result>{
    
        return UIBindingObserver(UIElement: base, binding: { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        })
    }
    
}

extension Reactive where Base: UITextField {
    
    
    var inputEnable:UIBindingObserver<Base,Result>{
    
        return UIBindingObserver(UIElement: base, binding: { (textfield, result) in
            
            textfield.isEnabled = result.isValidation
        })
    }
    
}
