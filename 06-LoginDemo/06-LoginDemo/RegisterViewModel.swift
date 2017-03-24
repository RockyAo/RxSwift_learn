//
//  RegisterViewModel.swift
//  06-LoginDemo
//
//  Created by Rocky on 2017/3/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import RxSwift
import RxCocoa

class RegisterViewModel {
    
    let userName = Variable<String>("")
    let passwordString = Variable<String>("")
    let repeatPasswordString = Variable<String>("")
    
    
    let userNameOutput:Observable<Result>
    let passwordOutput:Observable<Result>
    let repeatPasswordOutput:Observable<Result>
    
    
    let registerTaps = PublishSubject<Void>()
    
    
    let regisertButtonEnable:Observable<Bool>
    let registerResult:Observable<Result>
    
    
    init() {
        
        let vaildService = ValidationService.instance
        
        userNameOutput = userName.asObservable()
            .flatMapLatest{ userName in
                
                return vaildService.validateUserName(userName)
                        .observeOn(MainScheduler.instance)
                        .catchErrorJustReturn(.faild(message: "username检测出错"))
                
            }.shareReplay(1)
        
                
        passwordOutput = passwordString.asObservable()
            .map{ password  in
                
                return vaildService.validatePassword(password)
            }
            .shareReplay(1)
        
        repeatPasswordOutput = Observable.combineLatest(passwordString.asObservable(),repeatPasswordString.asObservable()){
            
                                return vaildService.validateRepeatPassword($0, $1)
                            }
                            .shareReplay(1)
        
        
        regisertButtonEnable = Observable.combineLatest(userNameOutput,passwordOutput,repeatPasswordOutput){ (userName,password,repeatPassword) in
            
            
            userName.isValidation && password.isValidation && repeatPassword.isValidation
        }
        .distinctUntilChanged()
        .shareReplay(1)
        
        let userNameAndPassword = Observable.combineLatest(userName.asObservable(),passwordString.asObservable()){
            
            ($0,$1)
        }
        
        
        registerResult = registerTaps.asObservable().withLatestFrom(userNameAndPassword)
            .flatMapLatest{ (userName , password) in
                
                return vaildService.register(userName, password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.faild(message:"注册出错"))
        }
        .shareReplay(1)
    }
}

