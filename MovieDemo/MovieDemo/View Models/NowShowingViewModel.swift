//
//  NowShowingViewModel.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
struct NowShowingViewModel
{
    var keyword : Variable<String> = Variable("")
    var arrMovies : Variable<[Movies]> = Variable([Movies]())
    
    init() {
        // Load local data
        loadNowShowing(page: "0")
    }
    
    // Load Movie Data of Now showing Category
    public func loadNowShowing(page:String)
    {
        //show progress
        if page == "0"
        {
            AppUtility.showProgress(text: "Please Wait...")
        }
        if AppUtility.CheckConnection()
        {
            let urlSearch = AppUtility.searhUrl(keyword: keyword.value, Page: page)
            ApiManager.shared.get(dict: NSMutableDictionary(), url: urlSearch, completionHandler: { success , response in
                
                //hide progress
                AppUtility.hideProgress()
                
                // parsign to get movie list
                let dict = response["results"] as! NSDictionary
                let array = dict["showing"]
                let arrObjMovies = Movies.modelsFromDictionaryArray(array: array as! NSArray)
                self.arrMovies.value.append(contentsOf: arrObjMovies)
            })
        }
        else
        {
            //hide progress
            AppUtility.hideProgress()
        }
    }
}
