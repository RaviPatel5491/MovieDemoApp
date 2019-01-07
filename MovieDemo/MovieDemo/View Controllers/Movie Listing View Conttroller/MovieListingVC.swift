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
        
        //self.navigationController?.isNavigationBarHidden = true
        
        //self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.barTintColor  = UIColor.white
        self.navigationController?.navigationBar.tintColor  = UIColor.black
        
        setupPageMenu()

        // Do any additional setup after loading the view.
    }
    
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
        controllerArray.append(objNowShowingMoviesVC)
        
        let objComingSoonMoviesVC = self.storyboard?.instantiateViewController(withIdentifier: "ComingSoonMoviesVC") as! ComingSoonMoviesVC
        objComingSoonMoviesVC.title = "Coming Soon"
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
            .selectionIndicatorColor(UIColor.blue)
        ]
        
        let topMargin:CGFloat = UIApplication.shared.statusBarFrame.size.height+self.navigationController!.navigationBar.frame.size.height;
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:topMargin, width:self.view.frame.width, height:self.view.frame.height - topMargin), pageMenuOptions: menuParam)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
