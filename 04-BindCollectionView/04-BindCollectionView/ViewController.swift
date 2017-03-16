//
//  ViewController.swift
//  04-BindCollectionView
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

