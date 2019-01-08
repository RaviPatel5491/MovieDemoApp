//
//  MovieListingVC.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

// This Base Class is container for Now showing and Coming soon ViewController


import UIKit
import PageMenu

class MovieListingVC: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    
    var keyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        setupPageMenu()
        createNavigation()
        // Do any additional setup after loading the view.
    }
    
    // Set navigationBar proporties
    func createNavigation()
    {
        self.title = "Movies"
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.barTintColor = colorPrimary
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // Setup UpperTab Menu Proporties
    func setupPageMenu()
    {
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        
        let objNowShowingMoviesVC = self.storyboard?.instantiateViewController(withIdentifier: "NowShowingMoviesVC") as! NowShowingMoviesVC
        objNowShowingMoviesVC.title = "Now Showing"
        objNowShowingMoviesVC.keyword = self.keyword
        controllerArray.append(objNowShowingMoviesVC)
        
        let objComingSoonMoviesVC = self.storyboard?.instantiateViewController(withIdentifier: "ComingSoonMoviesVC") as! ComingSoonMoviesVC
        objComingSoonMoviesVC.title = "Coming Soon"
        objComingSoonMoviesVC.keyword = self.keyword
        controllerArray.append(objComingSoonMoviesVC)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        
        let menuParam: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(1.0),
            .menuMargin(20.0),
            .menuHeight(50.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0),
            .selectedMenuItemLabelColor(UIColor.black),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectionIndicatorColor(colorPrimary)
        ]
        
        let topMargin:CGFloat = UIApplication.shared.statusBarFrame.size.height+self.navigationController!.navigationBar.frame.size.height;
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:topMargin, width:self.view.frame.width, height:self.view.frame.height - topMargin), pageMenuOptions: menuParam)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }
    
}
