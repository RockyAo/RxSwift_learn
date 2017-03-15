//: Playground - noun: a place where people can play

import UIKit

import RxSwift
import RxCocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


//connectable operators 连接操作符

///无连接操作
func sampleWithoutConnectableOperators(){

    printExampleHeader(#function)
    
    let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
       _ = interval.subscribe(onNext: {print("Subscription: 1, Event: \($0)") })
    
    
    delay(5) { 
        
        _ = interval.subscribe(onNext: { print("Subscription: 2, Event: \($0)") })
    }
}


//sampleWithoutConnectableOperators()


///publish

func sampleWithPublish(){
    
    printExampleHeader(#function)
    
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
    
    _ = intSequence.subscribe(onNext: {print("Subscription 1:, Event: \($0)") })
    
    delay(2) { 
        
        _ = intSequence.connect()
    }
    
    delay(4) { 
        
        _ =  intSequence.subscribe(onNext:{
            
            print("Subscription 2:, Event: \($0)")
        })
    }
    
    delay(6) { 
     
        _ =  intSequence.subscribe(onNext:{
            
            print("Subscription 3:, Event: \($0)")
        })
    }
    
    
    
}

//sampleWithPublish()


///replay

func sampleWithReplayBuffer(){

    printExampleHeader(#function)
    
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(5)
    
    intSequence.subscribe(onNext:{print("subscription 1:,event:\($0)")})
    
    delay(2) { 
        _ = intSequence.connect()
    }
    
    delay(4) { 
        _ = intSequence
            .subscribe(onNext:{ print("subscription 2: , event:\($0)")})
    }
    
    delay(8) { 
        
        _ =  intSequence
            .subscribe(onNext:{print("subscription 3:, event:\($0)")})
    }
    
}

//sampleWithReplayBuffer()

///multicast

func sampleWithMulticast() {
    printExampleHeader(#function)
    
    let subject = PublishSubject<Int>()
    
    _ = subject
        .subscribe(onNext: { print("Subject: \($0)") })
    
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .multicast(subject)
    
    _ = intSequence
        .subscribe(onNext: { print("\tSubscription 1:, Event: \($0)") })
    
    delay(2) { _ = intSequence.connect() }
    
    delay(4) {
        _ = intSequence
            .subscribe(onNext: { print("\tSubscription 2:, Event: \($0)") })
    }
    
    delay(6) {
        _ = intSequence
            .subscribe(onNext: { print("\tSubscription 3:, Event: \($0)") })
    }
}
//sampleWithMulticast()
