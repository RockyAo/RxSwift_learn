//
//  ViewController.swift
//  02-Counter
//
//  Created by Rocky on 2017/3/11.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var steper: UIStepper!
    
    fileprivate let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



}

