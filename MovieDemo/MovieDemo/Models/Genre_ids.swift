 //
 //  Genre_ids.swift
 //  MovieDemop
 //
 //  Created by Jigar Patel on 05/01/19.
 //  Copyright © 2019 BrainyBeam. All rights reserved.
 //
 
 // This Model class includes Gener IDs Parameters


import Foundation
 

public class Genre_ids {
	public var id : String?
	public var name : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let genre_ids_list = Genre_ids.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Genre_ids Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Genre_ids]
    {
        var models:[Genre_ids] = []
        for item in array
        {
            models.append(Genre_ids(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let genre_ids = Genre_ids(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Genre_ids Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary[GENRE_IDS_ID] as? String
		name = dictionary[GENRE_IDS_NAME] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: GENRE_IDS_ID)
		dictionary.setValue(self.name, forKey: GENRE_IDS_NAME)

		return dictionary
	}

}
