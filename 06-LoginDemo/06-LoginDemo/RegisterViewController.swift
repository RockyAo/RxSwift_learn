//
//  RegisterViewController.swift
//  06-LoginDemo
//
//  Created by Rocky on 2017/3/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var accountInputTextfield: UITextField!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordInputTextfield: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    fileprivate let disposebag = DisposeBag()
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountInputTextfield.rx.text.orEmpty
            .bindTo(viewModel.userName)
            .disposed(by: disposebag)
        
        viewModel.userNameOutput
            .bindTo(accountLabel.rx.validationResult)
            .disposed(by: disposebag)
        
        viewModel.userNameOutput
            .bindTo(passwordInputTextfield.rx.inputEnable)
            .disposed(by: disposebag)
        
        passwordInputTextfield.rx.text.orEmpty
            .bindTo(viewModel.passwordString)
            .disposed(by: disposebag)
        
        repeatPasswordTextfield.rx.text.orEmpty
            .bindTo(viewModel.repeatPasswordString)
            .disposed(by: disposebag)
        
        
        viewModel.passwordOutput
            .bindTo(passwordLabel.rx.validationResult)
            .disposed(by: disposebag)
        viewModel.passwordOutput
            .bindTo(repeatPasswordTextfield.rx.inputEnable)
            .disposed(by: disposebag)
        
        viewModel.repeatPasswordOutput
            .bindTo(repeatPasswordLabel.rx.validationResult)
            .disposed(by: disposebag)
        
        
        registerButton.rx.tap
            .bindTo(viewModel.registerTaps)
            .disposed(by: disposebag)
        
        
        viewModel.regisertButtonEnable
            .subscribe(onNext: { [unowned self] valid in
                
                self.registerButton.isEnabled = valid
                
                self.registerButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposebag)
        
        viewModel.registerResult
            .subscribe(onNext: { [unowned self] result in
                
                switch result{
                    
                case let .ok(message):
                    self.showAlert(message: message)
                case .empty:
                    self.showAlert(message: "登录错误")
                case let .faild(message):
                    self.showAlert(message: message)
                }
            })
            .disposed(by: disposebag)
    }
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
