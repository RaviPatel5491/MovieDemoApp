//
//  ViewController.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    var arrSearchKeyWords = [Search]()
    let searchController = UISearchController(searchResultsController: nil)
    let searchVM = SearchViewModel()

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
        self.SetupSearchController()
        
    }
    // MARK: - Helping Methods
    
   
//    func delay(_ delay: Double, closure: @escaping ()->()) {
//        let when = DispatchTime.now() + delay
//        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
//    }
    func getLastSearch()
    {
        arrSearchKeyWords =  searchVM.getLastSearchWords()
        tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrSearchKeyWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let objSearch = arrSearchKeyWords[indexPath.row]
        cell.textLabel!.text = objSearch.text
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objMovieListingVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListingVC") as! MovieListingVC
        self.navigationController?.pushViewController(objMovieListingVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            searchVM.deleteKeyWordToDB(rowid: arrSearchKeyWords[indexPath.row].rowId!)
            getLastSearch()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    // MARK: - Private instance methods

    func presentSearchController(_ searchController: UISearchController) {
        
    }
}

extension SearchVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchVM.addKeyWordToDB(keyword: searchBar.text!)
        let objMovieListingVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListingVC") as! MovieListingVC
        self.navigationController?.pushViewController(objMovieListingVC, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}




