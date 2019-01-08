//
//  AppUtility.swift
//  MovieDemo
//
//  Created by Jigar Patel on 06/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
// This class is used for util methods

import UIKit
import SVProgressHUD
import SystemConfiguration

class AppUtility {

    // This method show progress bar
   public static func showProgress(text:String)
    {
        DispatchQueue.main.async(execute: {() -> Void in
            SVProgressHUD.show(withStatus: text)
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
            SVProgressHUD.setForegroundColor(colorAccent)
        })
    }
    
    // Hide progress bar
    public static func hideProgress()
    {
        DispatchQueue.main.async(execute: {() -> Void in
            SVProgressHUD.dismiss()
        })
    }
    
    // DIctionary to JSON Formattor
    static func dictionaryToJson(dict: NSMutableDictionary) -> String {
        
        let jsonData: NSData;
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions()) as NSData;
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String;
            return jsonString;
        } catch _ {
            print("Error converting NSMutableDictionary to JSON string in DataUtils.");
        }
        return "";
    }
    
    // DIsplay alert with Text Method
    static func alertWithTitle(_ Title: String, Message: String, Cancelbtn: String, otherbutton: String)
    {
        DispatchQueue.main.async(execute: {() -> Void in
            let alertController = UIAlertController(title: Title, message:Message, preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: Cancelbtn, style: .default)
            let otherAction = UIAlertAction(title: otherbutton, style: .default)
            
            alertController.addAction(cancelAction)
            if otherbutton != ""
            {
                alertController.addAction(otherAction)
            }
            
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                topController.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    // Alert For Internet connectivity Status
    static func alertForInternet()
    {
        DispatchQueue.main.async(execute: {() -> Void in
            let alertController = UIAlertController(title: "", message:"Please check your internet connection!", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: { Void in
                    exit(0)
                })
            
            alertController.addAction(cancelAction)
           
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alertController, animated: true, completion: nil)
            }
        })
    }
    static func searhUrl(keyword:String,Page:String)->String
    {
        return SEARCH_URL + "keyword=\(keyword)&offset=\(Page)"
    }
    
    // This function checks Internet connection status
   static func CheckConnection() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // Get miliseconds from Date
    static func currentMiliSecond()->Double
    {
        let milliseconds: Int64 = Int64(Date().timeIntervalSince1970 * 1000.0)
        return Double(milliseconds)
    }
}
