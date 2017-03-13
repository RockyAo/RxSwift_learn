//: Playground - noun: a place where people can play

import UIKit
import RxCocoa
import RxSwift

//Transforming Operators : 用于处理,改变，转换一个观察者发出的信号序列上的事件

///map : 处理数据后将结果继续发送信号
exampleOf(description: "map") { 
    
    let disposedBag = DisposeBag()
    
    Observable.of(1,2,3)
        .map{ $0 * $0 }
        .subscribe(onNext:{print($0)})
        .disposed(by: disposedBag)
}

///flatMap and flatMapLatest
exampleOf(description: "flatMap and flatMapLatest") { 
    
    let disposeBag = DisposeBag()
    
    struct Player{
        
        var score:Variable<Int>
        
    }
    
    let player1 = Player(score: Variable(80))
    let player2 = Player(score: Variable(90))
    
    let player = Variable(player1)
    
    player.asObservable()
        .flatMap{$0.score.asObservable()}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
    
    player1.score.value = 5
    
   
    player.value = player2
    
    player1.score.value = 100
    player2.score.value = 101
}

exampleOf(description: "flatMapLatest") { 
    
    let disposeBag = DisposeBag()
    
    struct Player{
    
        var score:Variable<Int>
        
    }
    
    let player1 = Player.init(score: Variable(80))
    let player2 = Player.init(score: Variable(90))
    
    let player = Variable(player1)
    
    player.asObservable()
        .flatMapLatest{$0.score.asObservable()}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
    
    player1.score.value = 5
    
    player.value = player2
    
    player1.score.value = 100
    player2.score.value = 101
}

///scan
exampleOf(description: "scan") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(10,100,1000)
        .scan(1){ aggregateValue,newValue in
          
            print("\(aggregateValue)  \(newValue)")
            return aggregateValue + newValue
    }
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}
