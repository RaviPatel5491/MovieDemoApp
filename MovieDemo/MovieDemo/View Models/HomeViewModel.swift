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
    }
  
    
    func fetchHomeScreen() -> Observable<[Movies]> {
        if AppUtility.CheckConnection()
        {
            let url = URL(string: HOMEURL)
            return URLSession.shared.rx.json(url: url!)
                .retry(3)
                //.catchErrorJustReturn([])
                .map(parse)
        }
        else
        {
            //Hide progress
            AppUtility.hideProgress()
            AppUtility.alertForInternet()
        }
        return  Observable.just([])
    }
    
     func parse(json: Any) -> [Movies] {
        guard let items = json as? [[String: Any]]  else {
            return []
        }
        
        var array = [Movies]()
        array =  Movies.modelsFromDictionaryArray(array: items as NSArray)
        return array
    }
    
    public func fetchHomeData(completionHandler: @escaping (Bool,[Movies]) -> ())
    {
        //show progress
        AppUtility.showProgress(text: "Getting Movies...")
        if AppUtility.CheckConnection()
        {
            ApiManager.shared.get(dict: NSMutableDictionary(), url: HOMEURL, completionHandler: { success , response in
                
                //hide progress
                AppUtility.hideProgress()
                
                // parsign to get movie list
                let arrMovieDict = response["results"]
                self.arrMovies.value = Movies.modelsFromDictionaryArray(array: arrMovieDict as! NSArray)
                
                completionHandler(success,self.arrMovies.value)
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
