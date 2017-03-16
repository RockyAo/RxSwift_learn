//
//  ViewModel.swift
//  04-Network
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

struct ViewModel {
    
    let searchText = Variable("")
    
    fileprivate let disposebag = DisposeBag()
    
    lazy var data: Driver<[Repository]> = {
        
        let cself =  self
        
        return self.searchText.asObservable()
            .throttle(0.3,scheduler:MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest{
                cself.getRepositories(githubId: $0)
            }
            .asDriver(onErrorJustReturn:[])
    }()
    
    
    func getRepositories(githubId:String) -> Observable<[Repository]>{
        
        guard  !githubId.isEmpty,
            
            let url = URL(string: "https://api.github.com/users/\(githubId)/repos")
            
            else { return Observable.just([]) }
        
        
        return URLSession.shared
            .rx.json(url: url)
            .retry(3)
            .catchErrorJustReturn([])
            .map{
                
                
                var repository = [Repository]()
                
                if let item = $0 as? [[String:AnyObject]]{
                    
                    item.forEach{
                        
                        guard let name = $0["name"] as? String,
                            let url = $0["html_url"] as? String
                            else{ return }
                        
                        repository.append(Repository(name: name, url: url))
                    }
                }
                
                return repository
            }
    }

}

