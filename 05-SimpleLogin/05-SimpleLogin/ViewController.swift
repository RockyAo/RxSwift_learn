//
//  ViewController.swift
//  05-SimpleLogin
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minAccountLength = 5
let minPasswordLength = 5



class ViewController: UIViewController {

    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
     fileprivate let disposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        accountNameLabel.text = "用户名至少 \( minAccountLength) 位"
        passwordLabel.text = "密码至少 \( minPasswordLength) 位"
        
        let accountValid = accountTextfield.rx.text.orEmpty
            .map{ $0.characters.count >= minAccountLength}
            .shareReplay(1)
        
        let passwordValid = passwordTextfield.rx.text.orEmpty
            .map{ $0.characters.count >= minPasswordLength}
            .shareReplay(1)
        
        
        let finalValid = Observable.combineLatest(accountValid,passwordValid) {   $0 && $1  }
            .shareReplay(1)
        
        
        accountValid
            .bindTo(passwordTextfield.rx.isEnabled)
            .disposed(by: disposebag)
        
        accountValid
            .bindTo(accountNameLabel.rx.isHidden)
            .disposed(by: disposebag)
        
        passwordValid
            .bindTo(passwordLabel.rx.isHidden)
            .disposed(by: disposebag)
        
        finalValid
            .bindTo(loginButton.rx.isEnabled)
            .disposed(by: disposebag)
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .disposed(by: disposebag)
        
        
        
    }
    
    
    func showAlert() {
    
        let alert = UIAlertView(title:"登录成功", message: nil, delegate: nil, cancelButtonTitle: "确定")
        
        alert.show()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

