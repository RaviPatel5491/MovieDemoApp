//
//  HomeViewModel.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct HomeViewModel {
    
    var arrMovies = Variable<[Movies]>([])

    init() {
        // Load local data
        fetchHomeScreen()
    }
  
    func fetchHomeScreen() {
        //show progress
        AppUtility.showProgress(text: PROGRESS_GETTINGMOVIES)
        if AppUtility.CheckConnection()
        {
            ApiManager.shared.get(dict: NSMutableDictionary(), url: HOMEURL, completionHandler: { success , response in
                
                //hide progress
                AppUtility.hideProgress()
                
                // parsign to get movie list
                let arrMovieDict = response[RESPONSE_RESULT]
                self.arrMovies.value = Movies.modelsFromDictionaryArray(array: arrMovieDict as! NSArray)
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
