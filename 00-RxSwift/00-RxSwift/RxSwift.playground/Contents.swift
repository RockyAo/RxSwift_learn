//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


import RxSwift
import RxCocoa


///创建和订阅观察者

///never : 创建一个永远不会停止且发射事件的响应序列

exampleOf(description:"never"){

    let disposeBag = DisposeBag()
    
    let neverSequence = Observable<String>.never()
    
    neverSequence.subscribe{ _ in
    
        print("永远不会执行")
        
    }.disposed(by: disposeBag)
}

//代码简化

exampleOf(description: "simple never"){

    Observable<String>.never()
        .subscribe{ _ in
        
            print("永远不会执行")
            
    }.disposed(by: DisposeBag())
}


/// empty : 创建一个只发射完成事件的空响应序列
exampleOf(description: "empty"){

    Observable<Int>.empty()
        .subscribe{ event in
            
            print(event)
            
    }.disposed(by: DisposeBag())
}

/// just : 创建一个单一元素响应序列

exampleOf(description: "just"){

    Observable.just("我是对象")
        .subscribe{ event in
    
            print(event)
    }.addDisposableTo(DisposeBag())
}


///of : 创建一个确定对象响应序列

exampleOf(description: "of"){

    Observable.of(1,2,3)
    .subscribe(onNext: { (event) in
        print(event)
    }, onError: { (error) in
        print(error)
    }, onCompleted: {
        print("信号完成")
    }, onDisposed: { 
        print("信号序列释放")
    }).disposed(by: DisposeBag())
}

///from : 从一个序列创建一个响应序列：例如： 数组 ，字典，或者set集合
exampleOf(description: "from"){

    Observable.from(["lily","lilei","sb"])
    .subscribe(onNext: {
        
        print($0)
        
    }).disposed(by: DisposeBag())
    
}

/// create: 创建一个自定义响应序列
exampleOf(description: "create"){

    
    let myJust = { (element:String) -> Observable<String> in
    
        return Observable.create{ observable in
            
            observable.on(.next(element))
            
            observable.on(.completed)
            
            return Disposables.create()
        }
    }
    
    myJust("🍎")
        .subscribe{
    
            print($0)
    }.disposed(by: DisposeBag())
}

///range: 创建一个 发射连续整数区间（区间信后发射完成后停止）的响应序列
exampleOf(description: "range"){

    Observable.range(start: 1,count:10)
        .subscribe{
    
            print($0)
    }.disposed(by: DisposeBag())
}

///repeatElement: 创建一个 无限发射元素 （如果不进行设置不会停止）的响应序列  注意：需要写take限定次数。。否则真的不会停止（电脑卡爆了）
exampleOf(description: "repeatElement" ){

    Observable.repeatElement("🐩")
        .take(3)//至发射3次
        .subscribe{print($0)}
        .disposed(by: DisposeBag())
}

///generate: