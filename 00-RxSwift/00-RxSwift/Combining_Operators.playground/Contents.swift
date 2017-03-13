//: Playground - noun: a place where people can play

import UIKit
import RxCocoa
import RxSwift


////合并操作。   合并多个来源的响应者到一个响应者


///startWith : 在发射源事件之前  先发送其他事件 后写的先发送.所有start发射完成后 发送原始的

exampleOf(description: "startWith") { 
 
    Observable.of(1,2,3,4)
        .startWith(1)
        .startWith(2)
        .startWith(3,4,5)
        .subscribe(onNext:{print($0)})
        .disposed(by: DisposeBag())
}



