//
//  ViewController.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate {

    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - iPhone life cycle

    override func viewWillAppear(_ animated: Bool) {
        
        SetupNavigationBar()
//        self.searchController.searchBar.becomeFirstResponder()

//        delay(0.6) {
//            self.searchController.searchBar.becomeFirstResponder()
//        }
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
        self.SetupSearchController()
        
    }
    // MARK: - Helping Methods

    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
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
                textfield.textColor = UIColor.blue
                if let backgroundview = textfield.subviews.first {
                    
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10
                    backgroundview.clipsToBounds = true
                }
            }
            
            if let navigationbar = self.navigationController?.navigationBar {
                navigationbar.barTintColor = UIColor.blue
            }
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        
        
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        //navigationItem.searchController = searchController
        searchController.searchBar.showsCancelButton = true
        candies = [
            Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear"),
            Candy(category:"Other", name:"Candy Floss"),
            Candy(category:"Chocolate", name:"Chocolate Coin"),
            Candy(category:"Chocolate", name:"Chocolate Egg"),
            Candy(category:"Other", name:"Jelly Beans"),
            Candy(category:"Other", name:"Liquorice"),
            Candy(category:"Hard", name:"Toffee Apple")]
        
        
    }
    
    func SetupNavigationBar()
    {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.barTintColor  = UIColor.blue
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        if splitViewController!.isCollapsed {
//            if let selectionIndexPath = tableView.indexPathForSelectedRow {
//                tableView.deselectRow(at: selectionIndexPath, animated: animated)
//            }
//        }
//        super.viewWillAppear(animated)
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//
//
//        if splitViewController!.isCollapsed {
//            if let selectionIndexPath = tableView.indexPathForSelectedRow {
//                tableView.deselectRow(at: selectionIndexPath, animated: animated)
//            }
//        }
//        super.viewWillAppear(animated)
//    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            //searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
            return filteredCandies.count
        }
        
        //searchFooter.setNotFiltering()
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy: Candy
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel!.text = candy.name
        cell.detailTextLabel!.text = candy.category
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
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({( candy : Candy) -> Bool in
            let doesCategoryMatch = (scope == "All") || (candy.category == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
    }
    func presentSearchController(_ searchController: UISearchController) {
        
    }
}

extension ViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let objMovieListingVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListingVC") as! MovieListingVC
        self.navigationController?.pushViewController(objMovieListingVC, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
   
}

//extension ViewController: UISearchBarDelegate {
//    // MARK: - UISearchBar Delegate
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//
//        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
//}
//
//extension ViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        // let searchBar = searchController.searchBar
//        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!)
//
//    }
//}

