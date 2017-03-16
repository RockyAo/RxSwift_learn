//
//  ViewController.swift
//  03-BindTableView
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate let data = [
        
        Contributor(name: "lily", id: "00"),
        Contributor(name: "lilei", id: "01"),
        Contributor(name: "test", id: "02"),
        Contributor(name: "wang", id: "03"),
        Contributor(name: "zhangsan", id: "04"),
        Contributor(name: "lisi", id: "05"),
        Contributor(name: "wangwu", id: "06"),
        Contributor(name: "marry", id: "07"),
        Contributor(name: "tank", id: "08"),
        Contributor(name: "plane", id: "09"),
        Contributor(name: "ghost", id: "10"),
        Contributor(name: "way", id: "11"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        let contributor = data[indexPath.row]
        
        cell.textLabel?.text = contributor.name
        cell.detailTextLabel?.text = contributor.id
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(data[indexPath.row].description)
    }

}

