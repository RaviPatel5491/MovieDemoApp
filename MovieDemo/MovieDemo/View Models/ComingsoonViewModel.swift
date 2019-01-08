//
//  ComingsoonViewModel.swift
//  MovieDemo
//
//  Created by Jigar Patel on 08/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
struct ComingsoonViewModel {
    let keyword = Variable("")
    var arrMovies : Variable<[Movies]> = Variable([Movies]())
    
    init() {
        // Load local data
        loadComingSoon(page: "0")
    }

   
    // Load movie Data of Coming Soon Category
    public func loadComingSoon(page:String)
    {
        //show progress
        if page == "0"
        {
            AppUtility.showProgress(text: PROGRESS_GETTINGMOVIES)
        }
        if AppUtility.CheckConnection()
        {
            let urlSearch = AppUtility.searhUrl(keyword: keyword.value, Page: page)
            ApiManager.shared.get(dict: NSMutableDictionary(), url: urlSearch, completionHandler: { success , response in
                
                // parsign to get movie list
                let dict = response[RESPONSE_RESULT] as! NSDictionary
                let array = dict[CATEGORY_UPCOMING]
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
//
}
