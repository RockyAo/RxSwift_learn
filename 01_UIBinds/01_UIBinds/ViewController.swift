//
//  ViewController.swift
//  01_UIBinds
//
//  Created by Rocky on 2017/3/15.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

