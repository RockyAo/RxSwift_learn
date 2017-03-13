//: Playground - noun: a place where people can play

import RxCocoa
import RxSwift


// 过滤原始数据流（整出一些有用的数据）

/// filter: 过滤出符合条件的数据

exampleOf(description: "filter") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(1,2,3,4,5,6,7,8,9,10)
        .filter{$0 > 4}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}


///distinctUntilChanged 等同于过滤重复数据

exampleOf(description: "distinctUntilChanged") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(1,2,3,4,5,5,5,5,6,6,7)
        .distinctUntilChanged()
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///elementAt : 过滤出确定位置的元素
exampleOf(description: "elementAt") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(1,2,3,4,5,6,7)
        .elementAt(3)
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///single: 过滤出第一个元素(或者符合条件的第一个元素)，继续发送。 如果响应者有多个元素。会抛出error
exampleOf(description: "single") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(1,2,3)
        .single()
        .subscribe{print($0)}
        .disposed(by: disposeBag)
    print("-----------------------分割线----------------------")
    
    Observable.of(1)
        .single()
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

exampleOf(description: "single with conditions") { 
    
    let disposeBag = DisposeBag()

    Observable.of(1,2,3,4)
        .single{ $0 > 1}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
    
    print("-----------------------分割线----------------------")
    Observable.of(1,2)
        .single{$0 > 1}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///take:  执行几次。
exampleOf(description: "take") {
    let disposeBag = DisposeBag()

    
    Observable.of(1,2,3,4,5)
        .take(2)
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///takeLast :反向

exampleOf(description: "takeLast") { 
    
    let disposeBag = DisposeBag()

    Observable.of(1,2,3,4,5)
        .takeLast(2)
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///takeWhile: 按条件过滤。类似于filter. take 会从第一个开始
exampleOf(description: "takeWhile") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of(1,2,3,4,5)
        .takeWhile{$0 < 4}
        .subscribe{print($0)}
        .disposed(by: disposeBag)

}

///takeUntil : 源信号一直发送，知道参照序列开始发送信号就停止,且参照信号并不会被订阅者接收

exampleOf(description: "takeUntil") { 
    
    let disposeBag = DisposeBag()
    
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .takeUntil(referenceSequence)
        .subscribe { print($0) }
        .disposed(by: disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}

///skip: 跳过第几个元素,从开始到结束计算

exampleOf(description: "skip") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .skip(2)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

}

///skipWhile：符合条件跳过
exampleOf(description: "skipWhile") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .skipWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}


///skipWhileWithIndex：按条件跳过

exampleOf(description: "skipWhileWithIndex") { 
    
    let disposeBag = DisposeBag()

    
    Observable.of(1,2,3,4,5,6,7)
        .skipWhile({ (index) -> Bool in
            return index < 3
        })
        .subscribe{print($0)}
        .disposed(by: disposeBag)
}

///skipUntil,源信号等待参照信号第一次发送信号后，开始发送信号

exampleOf(description: "skipUntil") { 
    
    let disposeBag = DisposeBag()
    
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .skipUntil(referenceSequence)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}