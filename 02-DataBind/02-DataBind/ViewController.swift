//
//  ViewController.swift
//  02-DataBind
//
//  Created by Rocky on 2017/3/15.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var textfield: UITextField!
    
    fileprivate let disposebag = DisposeBag()
    
    
    fileprivate let textfieldText = Variable("")
    
    fileprivate let buttonTaped = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tapGestureRecognizer.rx.event.asDriver()
            .drive(onNext: { [unowned self] _ in
                
                self.view.endEditing(true)
            }).addDisposableTo(disposebag)
        
        
        button.rx.tap.map{
        
            "tapped!"
        }.bindTo(buttonTaped)
         .addDisposableTo(disposebag)
        
        
        buttonTaped.subscribe { (event) in
            print(event)
        }.addDisposableTo(disposebag)
        
    
        textfield.rx.text.map{ text in
                return text ?? ""
            }.bindTo(textfieldText)
            .addDisposableTo(disposebag)

        textfieldText.asObservable()
            .subscribe{
        
                print($0)
        }.addDisposableTo(disposebag)
    }
    
    
    
   

}

