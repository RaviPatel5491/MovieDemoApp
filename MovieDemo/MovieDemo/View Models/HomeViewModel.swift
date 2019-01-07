//
//  HomeViewModel.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

import UIKit

struct HomeViewModel {

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
                let array = response["results"]
                let arrMovieDict = Movies.modelsFromDictionaryArray(array: array as! NSArray)
                completionHandler(success,arrMovieDict)
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
