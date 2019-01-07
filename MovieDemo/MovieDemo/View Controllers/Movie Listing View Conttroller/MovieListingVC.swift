//
//  MovieListingVC.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import PageMenu

class MovieListingVC: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar Proporties
        self.navigationController?.navigationBar.barTintColor  = UIColor.white
        self.navigationController?.navigationBar.tintColor  = UIColor.black
        
        setupPageMenu()
    }
    
    func setupPageMenu()
    {
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        
        let objNowShowingMoviesVC = self.storyboard?.instantiateViewController(withIdentifier: "NowShowingMoviesVC") as! NowShowingMoviesVC
        objNowShowingMoviesVC.title = "Now Showing"
        controllerArray.append(objNowShowingMoviesVC)
        
        let objComingSoonMoviesVC = self.storyboard?.instantiateViewController(withIdentifier: "ComingSoonMoviesVC") as! ComingSoonMoviesVC
        objComingSoonMoviesVC.title = "Coming Soon"
        controllerArray.append(objComingSoonMoviesVC)
        
        // Customize page menu customization
        
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
            .selectionIndicatorColor(UIColor.blue)
        ]
        
        let topMargin:CGFloat = UIApplication.shared.statusBarFrame.size.height+self.navigationController!.navigationBar.frame.size.height;
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:topMargin, width:self.view.frame.width, height:self.view.frame.height - topMargin), pageMenuOptions: menuParam)
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }
}
