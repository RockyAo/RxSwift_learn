//
//  ViewController.swift
//  04-Network
//
//  Created by Rocky on 2017/3/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBar:UISearchBar { return searchController.searchBar}
    
    var viewModel = ViewModel()
    
    fileprivate let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureSearchController()
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "Cell")){ _ ,repository,cell in
             
                cell.textLabel?.text = repository.name
                
                cell.detailTextLabel?.text = repository.url
            }
            .addDisposableTo(disposebag)
        
        searchBar.rx.text
            .map{
                return $0 ?? ""
            }
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposebag)
        
        searchBar.rx.cancelButtonClicked
            .map{"RockyAo"}
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposebag)
        
        viewModel.data.asDriver()
            .map{ return "\($0.count) repositry"}
            .drive(navigationItem.rx.title)
            .addDisposableTo(disposebag)
        
    }
    
    
        
    
    
    func configureSearchController(){
    
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "RockyAo"
        searchBar.placeholder = "enter github id"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

}

