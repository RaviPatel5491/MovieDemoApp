//
//  Search.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

// This Model class includes Search Parameters

import Foundation

public class Search {
    public var rowId : Int?
	public var text : String?
	public var timestamp : Double?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Search_list = Search.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Search Instances.
*/
    init() {
        
    }
    public class func modelsFromDictionaryArray(array:NSArray) -> [Search]
    {
        var models:[Search] = []
        for item in array
        {
            models.append(Search(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Search = Search(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Search Instance.
*/
	required public init?(dictionary: NSDictionary) {
        rowId = dictionary[T_SEARCH_ID] as? Int
		text = dictionary[T_SEARCH_TEXT] as? String
		timestamp = dictionary[T_SEARCH_TS] as? Double
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.text, forKey: T_SEARCH_TEXT)
		dictionary.setValue(self.timestamp, forKey: T_SEARCH_TS)
        dictionary.setValue(self.rowId, forKey: T_SEARCH_ID)
		return dictionary
	}
    public func dictionaryRepresentationTable() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.text, forKey: T_SEARCH_TEXT)
        dictionary.setValue(self.timestamp, forKey: T_SEARCH_TS)
        return dictionary
    }

}
