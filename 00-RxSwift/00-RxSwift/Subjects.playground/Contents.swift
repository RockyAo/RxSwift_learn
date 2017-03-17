//: Playground - noun: a place where people can play

import UIKit

import RxCocoa
import RxSwift


extension ObservableType{

    ///给每一个观察者增加一个id。并打印id和发射的事件
    func addObservable(_ id:String) -> Disposable {
        
        return subscribe{
        
            print("Subscription:", id, "Event:", $0)
        }
    }
}


func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) -> Disposable {
    return sequence.subscribe { event in
        print("Subscription: \(name), event: \(event)")
    }
}


///PublishSubject: 与普通 subject的区别。subject被订阅时不会触发信号。在其生命周期内手动调用。 该响应会发送给每一个订阅者

exampleOf(description: "PublishSubject") { 
    
    let disposeBag = DisposeBag()
    
    let publishSubject = PublishSubject<String>()
    
    ///第一组
    publishSubject.addObservable("no.1").disposed(by: disposeBag)
    
    publishSubject.onNext("2")
    
    publishSubject.onNext("3")
    
    //第二组
    publishSubject.addObservable("no.2").disposed(by: disposeBag)
    
    publishSubject.onNext("🐱")
    
    publishSubject.onNext("🐶")
}


///ReplaySubject ,发送事件到每一个订阅者。 如果指定了bufferSize（第几个订阅者？）,会把新订阅者订阅时之前的几个（倒叙）事件发送给新的订阅者. 栗子：如下面 如果bufferSize指定为0，那么新的订阅者不会接收到任何事件.如果指定为1，no.2 订阅者 在订阅时 会收到之前的一个事件即第二个事件.如果指定为2,新的订阅者会收到之前的两个事件(第二个事件和第一个事件)。  回放之前的事件


exampleOf(description: "replaySubject") { 
    
    let disposeBag = DisposeBag()
    
    let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
    
    replaySubject.addObservable("no.1").disposed(by: disposeBag)
    
    replaySubject.onNext("第一个事件")
    
    replaySubject.onNext("第二个事件")

    
    
    replaySubject.addObservable("no.2").disposed(by: disposeBag)
    
    replaySubject.onNext("3")
    
    replaySubject.onNext("4")
    
}

///BehaviorSubject : 会有一个初始值，这个值会发送给第一个订阅者。 其他事件会发送给所有订阅者。最近的一个事件会发送给新的订阅者
exampleOf(description: "BehaviorSubject") { 
    
    let disposeBag = DisposeBag()
    
    let subject = BehaviorSubject(value: "behavior")
    
    subject.addObservable("第一个响应").disposed(by: disposeBag)
    
    subject.onNext("第一个事件")
    
    subject.onNext("第二个事件")
    
    subject.addObservable("第二个响应").disposed(by: disposeBag)
    
    subject.onNext("第三个事件")
    
    subject.onNext("第四个事件")
}


///Variable: 包含了BehaviorSubject ，所以拥有 BehaviorSubject 的特性。会将最近的一个事件发送给新的订阅者. 同时Variable，不会发送错误事件，但是自动发送完成事件来中断信号流


exampleOf(description: "Variable") { 
    
    let disposeBag = DisposeBag()
    
    let variable = Variable<String>("默认值")
    
    variable.asObservable().addObservable("no.1").disposed(by: disposeBag)
    
    variable.value = "第二个值"
    
    variable.value = "第三个值"
    
    variable.asObservable().addObservable("no.2").disposed(by: disposeBag)
    
    variable.value = "第四个值"
    
    variable.value = "第五个值"
}




