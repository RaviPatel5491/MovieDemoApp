//
//  HomeViewModel.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

import UIKit
class Dynamic<T> {
    
    var bind :(T) -> () = { _ in }
    
    var value :T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v :T) {
        value = v
    }
    
}
struct HomeViewModel {
    var arrMovies : Dynamic<[Movies]> = Dynamic([Movies]())

    public func fetchHomeData(completionHandler: @escaping (Bool,[Movies]) -> ())
    {
        //show progress
        AppUtility.showProgress(text: "Please Wait...")
        if AppUtility.CheckConnection()
        {
            ApiManager.shared.get(dict: NSMutableDictionary(), url: HOMEURL, completionHandler: { success , response in
                
                //hide progress
                AppUtility.hideProgress()
                
                // parsign to get movie list
                let arrMovieDict = response["results"]
                self.arrMovies.value = Movies.modelsFromDictionaryArray(array: arrMovieDict as! NSArray)
                
                completionHandler(success,self.arrMovies.value!)
            })
        }
        else
        {
            //hide progress
            AppUtility.hideProgress()
            AppUtility.alertForInternet()
        }
    }
}
