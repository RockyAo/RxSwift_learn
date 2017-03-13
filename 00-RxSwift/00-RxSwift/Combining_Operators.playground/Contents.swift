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

///merge: 合并两个源响应者。不管哪个响应者发送事件，订阅者只收到一个
exampleOf(description: "merge") { 
    
    let disposeBag = DisposeBag()
    
    let subject1 = PublishSubject<String>()
    
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1,subject2)
        .merge()
        .subscribe{print($0)}
        .disposed(by: disposeBag)
    
    subject1.onNext("第一个事件")
    subject1.onNext("第二个事件")
    
    subject2.onNext("第三个事件")
    subject2.onNext("第四个事件")
    
    subject1.onNext("第五个事件")
    subject2.onNext("第六个事件")
}

/// zip: 多个不同响应者 同时发送事件 ，订阅者才会接收到

exampleOf(description: "zip") {
    
    let disposeBag = DisposeBag()
    
    let stringSubject = PublishSubject<String>()
    
    let intSubject = PublishSubject<Int>()
    
    Observable.zip(stringSubject,intSubject ){ (stringElement,intElement)  in
        
            "\(stringElement)\(intElement)"
    }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
    
    stringSubject.onNext("A事件")
    stringSubject.onNext("B事件")
    
    intSubject.onNext(1)
    intSubject.onNext(2)
    
    stringSubject.onNext("C事件")
    intSubject.onNext(3)
}



///combineLatest: 合并两个源，组合成新的数据流。 最后一个发送事件的响应者会和他前面的响应者的最后一个事件组合

exampleOf(description: "combineLatest") { 
    
    let disposeBag = DisposeBag()
    
    let stringSubject = PublishSubject<String>()
    
    let intSubject = PublishSubject<Int>()
    
    
    Observable.combineLatest(stringSubject,intSubject) { (stringElement,intElement)  in
        
        "\(stringElement) \(intElement)"
    }
        .subscribe{print($0)}
        .disposed(by: disposeBag)

    stringSubject.onNext("A事件")
    stringSubject.onNext("B事件")
    
    intSubject.onNext(1)
    intSubject.onNext(2)
    
    stringSubject.onNext("AB事件")
}

exampleOf(description: "ArrayCombineLatest") { 
    
    let disposeBag = DisposeBag()
    
    
    /////数据流中所有数据类型需要一致
    let stringObservable = Observable.just("第一个observable")
    
    let arrayObservable = Observable.from(["1","2","3","4","5"])
    
    let animalObservable = Observable.of("狗","猫","王八","兔子")
    
    Observable.combineLatest([stringObservable,arrayObservable,animalObservable]) {
        "\($0[0]) \($0[1]) \($0[2])"
        }.subscribe{
            print($0)
        }.disposed(by:disposeBag)
}

///switchLatest: 转换一个响应序列到另一响应序列上。并且把事件发送给最近的一个响应序列
exampleOf(description:"switchLatest"){

    let disposeBag = DisposeBag()
    
    let subject1 = BehaviorSubject(value:"no.1")
    
    let subject2 = BehaviorSubject(value:"no.2")
    
    let variable = Variable(subject1)
    
    variable.asObservable()
        .switchLatest()
        .subscribe{print($0)}
        .disposed(by:disposeBag)
    
    subject1.onNext("第一个事件")
    subject1.onNext("第二个事件")
    
    variable.value = subject2
    
    subject2.onNext("第三个事件")
    subject2.onNext("第四个事件")
}