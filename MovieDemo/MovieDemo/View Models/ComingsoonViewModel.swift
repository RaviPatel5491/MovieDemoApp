//
//  ComingsoonViewModel.swift
//  MovieDemo
//
//  Created by Jigar Patel on 08/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

struct ComingsoonViewModel {
    var keyword : Dynamic<String> = Dynamic("")
    var arrMovies : Dynamic<[Movies]> = Dynamic([Movies]())
    public func loadComingSoon(page:String,completionHandler: @escaping (Bool,[Movies]) -> ())
    {
        //show progress
        if page == "0"
        {
            AppUtility.showProgress(text: "Please Wait...")
        }
        if AppUtility.CheckConnection()
        {
            let urlSearch = AppUtility.searhUrl(keyword: keyword.value!, Page: page)
            ApiManager.shared.get(dict: NSMutableDictionary(), url: urlSearch, completionHandler: { success , response in
                
                //hide progress
                AppUtility.hideProgress()
                
                // parsign to get movie list
                let dict = response["results"] as! NSDictionary
                let array = dict["upcoming"]
                let arrMovieDict = Movies.modelsFromDictionaryArray(array: array as! NSArray)
                completionHandler(success,arrMovieDict)
            })
        }
        else
        {
            //hide progress
            AppUtility.hideProgress()
        }
    }
}
