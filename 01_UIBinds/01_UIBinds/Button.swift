//
//  Button.swift
//  01_UIBinds
//
//  Created by Rocky on 2017/3/15.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 5.0
    }

}
