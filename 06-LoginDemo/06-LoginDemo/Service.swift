//
//  Service.swift
//  06-LoginDemo
//
//  Created by Rocky on 2017/3/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

let minCharacterCount = 6
let maxCharacterCount = 12



class ValidationService {
    
    static let instance = ValidationService()
    
    func validateUserName(_ userName:String) -> Observable<Result>{
    
        if userName.characters.count == 0 {
            return .just(.empty)
        }
        
        if userName.characters.count < minCharacterCount{
            
            return .just(.faild(message:"账号至少\(minCharacterCount)个字符"))
        }
        
        if validateLocalUserName(userName) {
            
            return .just(.faild(message:"用户名已存在"))
        }
        
        if userName.characters.count > maxCharacterCount {
            
            return .just(.faild(message:"账号不能大于\(maxCharacterCount)个字符"))
        }
        
        return .just(.ok(message:"用户名可用"))
    }
    
    func validateLocalUserName(_ userName:String) -> Bool{
        
        let filePath = NSHomeDirectory() + "/Documents/user.plist"
        
        guard let userDictionary = NSDictionary(contentsOfFile: filePath) else {
        
            return false
        }
        
        let usernameArray = userDictionary.allKeys as NSArray
        
        if usernameArray.contains(userName) {
            return true
        } else {
            return false
        }
    }
    
    
    func validatePassword(_ password:String) -> Result {
        
        if password.characters.count == 0 {
            
            return .empty
        }
        
        if password.characters.count < minCharacterCount {
            
            return .faild(message:"密码至少6位")
        }
        
        if password.characters.count > maxCharacterCount {
            
            return .faild(message:"密码最多12位")
        }
        
        return .ok(message:"验证通过")
    }
    
    
    func validateRepeatPassword(_ password:String,_ repeatPassword:String) -> Result{
        
        if repeatPassword.characters.count == 0 {
            
            return .empty
        }
        
        if repeatPassword == password {
            
            return .ok(message:"密码可用")
        }
        
        return .faild(message:"两次输入不一致")
    }
    
    
    func register(_ username:String,_ password:String) -> Observable<Result> {
        
        let userdic = [username:password]
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (userdic as NSDictionary).write(toFile: filePath, atomically: true) {
            
            return .just(.ok(message:"写入成功"))
        }
        
        return .just(.ok(message:"注册失败"))
        
    }
}
