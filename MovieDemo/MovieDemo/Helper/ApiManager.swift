//
//  ApiManager.swift
//  MovieDemo
//
//  Created by Jigar Patel on 06/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import Alamofire
class ApiManager {
    static let shared = ApiManager()
    
    func post(dict:NSMutableDictionary,url:String , completionHandler: @escaping (Bool,NSMutableDictionary) -> ())
    {
        
        var requestAla = URLRequest(url: URL(string: url)!)
        requestAla.httpMethod = "POST"
        do
        {
            requestAla = try URLEncoding.default.encode(requestAla, with: dict as? Parameters)
        }
        catch
        {
            
        }
        Alamofire.request(requestAla).responseJSON
            { response in
                
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8)
                    {
                        print(responseString)
                        
                        let dictnil = NSMutableDictionary()
                        completionHandler(false,dictnil)
                        
                    }
                case .success(let responseObject):
                    
                    let dict = responseObject as! NSDictionary
                    let mutableDict = dict.mutableCopy() as! NSMutableDictionary
                    print(mutableDict)
                    if mutableDict.allKeys.count == 0
                    {
                        completionHandler(false,mutableDict)
                    }
                    else if let val = mutableDict.value(forKey: "Responce_code")
                    {
                        let resultCount = val as! String
                        
                        if resultCount == "200"
                        {
                            completionHandler(true,mutableDict)
                        }
                        else
                        {
                            completionHandler(false,mutableDict)
                        }
                    }
                    
                }
        }
    }
    
    func get(dict:NSMutableDictionary,url:String , completionHandler: @escaping (Bool,NSMutableDictionary) -> ())
    {
        
        var requestAla = URLRequest(url: URL(string: url)!)
        requestAla.httpMethod = "GET"
        do
        {
            requestAla = try URLEncoding.default.encode(requestAla, with: dict as? Parameters)
        }
        catch
        {
            
        }
        Alamofire.request(requestAla).responseJSON
            { response in
                
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8)
                    {
                        print(responseString)
                        
                        let dictnil = NSMutableDictionary()
                        completionHandler(false,dictnil)
                        
                    }
                case .success(let responseObject):
                    
                    let dict = responseObject as! NSDictionary
                    let mutableDict = dict.mutableCopy() as! NSMutableDictionary
                    print(mutableDict)
                    if mutableDict.allKeys.count == 0
                    {
                        completionHandler(false,mutableDict)
                    }
                    else if let val = mutableDict.value(forKey: "Responce_code")
                    {
                        let resultCount = val as! String
                        
                        if resultCount == "200"
                        {
                            completionHandler(true,mutableDict)
                        }
                        else
                        {
                            completionHandler(false,mutableDict)
                        }
                    }
                    
                }
        }
    }
}
