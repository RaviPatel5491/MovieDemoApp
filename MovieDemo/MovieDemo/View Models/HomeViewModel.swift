//
//  HomeViewModel.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

import UIKit

struct HomeViewModel {

    public static func fetchHomeData()
    {
        AppUtility.showProgress(text: "Please Wait...")
        ApiManager.shared.get(dict: NSMutableDictionary(), url: HOMEURL, completionHandler: { success , response in
            if success
            {
               print(response)
            }
            else
            {
                
            }
        })
    }
}
