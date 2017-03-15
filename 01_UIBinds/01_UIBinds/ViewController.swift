//
//  ViewController.swift
//  01_UIBinds
//
//  Created by Rocky on 2017/3/15.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var textView: TextView!
    
    @IBOutlet weak var textViewLabel: UILabel!
    
    @IBOutlet weak var button: Button!
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var segmentControlLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerLabel: UILabel!
    
    fileprivate let disposebag = DisposeBag()
    
    lazy var dateFormatter: DateFormatter = {
        
        let formatter =  DateFormatter()
        
        formatter.dateStyle = .medium
        
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ///点击手势
        tapGestureRecognizer.rx.event
            .bindNext { [unowned self] recognizer in
                
                self.view.endEditing(true)
                
        }.addDisposableTo(disposebag)
        
        ///输入框和label
        textField.rx.text.asDriver()
            .drive(textFieldLabel.rx.text)
            .addDisposableTo(disposebag)
        
        
        ///bindTo
        textView.rx.text
            .bindNext{ [unowned self] in
                
                self.textViewLabel.text = "字节数：\($0?.characters.count ?? 0)"
                
        }.addDisposableTo(disposebag)
        
        ///button
        
        button.rx.tap.asDriver()
            .drive(onNext: { [unowned self] in
            
                self.buttonLabel.text! += "Tapped!"
                
                self.view.endEditing(true)
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.view.layoutIfNeeded()
                })
                
            }, onCompleted: {
                
                print("事件完成")
                
            }, onDisposed: {
            
                print("释放")
            }).addDisposableTo(disposebag)
        
        
        ///segmentControlelr
        
        segmentControl.rx.value.asDriver()
            .skip(1)
            .drive(onNext: { [unowned self] in
                self.segmentControlLabel.text = "选中 segment:\($0)"
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.view.layoutIfNeeded()
                })
            }, onCompleted: {
                
            }, onDisposed: {
            
            }).addDisposableTo(disposebag)
        
        
        ///slider
        slider.rx.value.asDriver()
            .drive(progressView.rx.progress)
            .addDisposableTo(disposebag)
        
        ///switch
        switchButton.rx.value.asDriver()
            .map { $0 }
            .drive(activityIndicator.rx.isAnimating)
            .addDisposableTo(disposebag)
        
        ///stepper
        stepper.rx.value.asDriver()
            .map{String(Int($0))}
            .drive(stepperLabel.rx.text)
            .addDisposableTo(disposebag)
        
        ///datepicker
        
        datePicker.rx.date.asDriver()
            .map{ [unowned self] in
                
                self.dateFormatter.string(from: $0) 
            }
            .drive(onNext: {  [unowned self] (event) in
                
                self.datePickerLabel.text = "选中: \(event)"
                
            }, onCompleted: {
                
                
            }, onDisposed: {
            
                
            }).addDisposableTo(disposebag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

