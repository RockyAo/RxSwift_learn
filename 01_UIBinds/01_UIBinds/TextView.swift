//
//  TextView.swift
//  01_UIBinds
//
//  Created by Rocky on 2017/3/15.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class TextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    
    func config(){
    
        layer.cornerRadius = 5.0
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
    }
}
