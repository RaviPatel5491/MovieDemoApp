//
//  ViewController.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController , UISearchControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    var arrSearchKeyWords = [Search]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchVM = SearchViewModel()
    var disposeBag = DisposeBag()

    // MARK: - iPhone life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        SetupNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        //       searchController.isActive = true
        DispatchQueue.main.async { [unowned self] in
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        self.getLastSearch()
        self.setupTable()
        self.bindSearchBar()
        self.SetupSearchController()
        
    }
    // MARK: - Helping Methods
    func getLastSearch()
    {
        //bind tableview
        searchVM.arrSearch.asObservable().bind(to: tableView.rx.items(cellIdentifier: "Cell"))(setupCell)
            .addDisposableTo(disposeBag)
    }
    private func bindSearchBar() {
        searchController.searchBar.rx.text.asObservable()
            .filter{$0 != nil}
            .subscribe(onNext: {
                text in
                self.searchVM.searchText.value = text!
            }).disposed(by: disposeBag)
    }
    
    func SetupSearchController()
    {
        if #available(iOS 11.0, *) {
            //let sc = UISearchController(searchResultsController: nil)
            searchController.delegate = self
            searchController.searchBar.delegate = self
            let scb = searchController.searchBar
            scb.tintColor = UIColor.white
            scb.barTintColor = UIColor.white
            
            if let textfield = scb.value(forKey: "searchField") as? UITextField {
                textfield.textColor = colorPrimary
                if let backgroundview = textfield.subviews.first {
                    
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10
                    backgroundview.clipsToBounds = true
                }
            }
            
            if let navigationbar = self.navigationController?.navigationBar {
                navigationbar.barTintColor = colorPrimary
            }
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        
        
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        //navigationItem.searchController = searchController
        searchController.searchBar.showsCancelButton = true
    }
    
    func SetupNavigationBar()
    {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.barTintColor  = colorPrimary
    }
    
   
    
    // MARK: - Table View
    func setupTable()
    {
        //item select
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let objMovieListingVC = self?.storyboard?.instantiateViewController(withIdentifier: "MovieListingVC") as! MovieListingVC
                objMovieListingVC.keyword = (self?.searchVM.arrSearch.value[indexPath.row].text!)!
                self?.navigationController?.pushViewController(objMovieListingVC, animated: true)
            }).addDisposableTo(disposeBag)
        
        //delete selected
        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                
                self?.searchVM.deleteKeyWordToDB(rowid: (self?.arrSearchKeyWords[indexPath.row].rowId!)!)
                self?.getLastSearch()
                
            }).addDisposableTo(disposeBag)
    }
    private func setupCell(row: Int,search:Search, cell: UITableViewCell){
        cell.textLabel?.text = search.text
        cell.detailTextLabel?.text = search.text
    }
}

extension SearchVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let trimmedString = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.count == 0
        {
            AppUtility.alertWithTitle("", Message: "Please enter search text", Cancelbtn: "Ok", otherbutton: "")
            return
        }
        searchVM.addKeyWordToDB(keyword: trimmedString)
        let objMovieListingVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListingVC") as! MovieListingVC
        objMovieListingVC.keyword = trimmedString
        self.navigationController?.pushViewController(objMovieListingVC, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}




