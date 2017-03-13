//: Playground - noun: a place where people can play
import RxCocoa
import RxSwift

///数学集合操作

/// toArray: 转换一个信号为单一数组信号继续发送，之后终止

exampleOf(description: "toArray") { 
    
    let disposeBag = DisposeBag()
    
    Observable.range(start: 1, count: 10)
        .toArray()
        .subscribe { print($0) }
        .disposed(by: disposeBag)

}

///reduce ，所有元素进行计算 结果合并成新的单一信号发送
exampleOf(description: "reduce") { 
    
    
    let disposeBag = DisposeBag()
    
    Observable.of(10, 100, 1000)
        .reduce(1, accumulator: +)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}

///concat 这条没看明白

exampleOf(description: "concat") { 
    
    let disposeBag = DisposeBag()
    
    let subject1 = BehaviorSubject(value: "🍎")
    let subject2 = BehaviorSubject(value: "🐶")
    
    let variable = Variable(subject1)
    
    variable.asObservable()
        .concat()
        .subscribe { print($0) }
        .disposed(by: disposeBag)
    
    subject1.onNext("🍐")
    subject1.onNext("🍊")
    
    variable.value = subject2
    
    subject2.onNext("I would be ignored")
    subject2.onNext("🐱")
    
    subject1.onCompleted()
    
    subject2.onNext("🐭")

}