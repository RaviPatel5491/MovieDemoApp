//
//  AppUtility.swift
//  MovieDemo
//
//  Created by Jigar Patel on 06/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import SVProgressHUD
class AppUtility {

   public static func showProgress(text:String)
    {
        DispatchQueue.main.async(execute: {() -> Void in
            SVProgressHUD.show(withStatus: text)
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
            SVProgressHUD.setForegroundColor(colorAccent)
        })
    }
    
    
}
