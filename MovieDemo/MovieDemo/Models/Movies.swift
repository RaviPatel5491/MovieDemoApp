//
//  Movies.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

// This Model class includes Movie Data Parameters


import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Movies {
	public var poster_path : String?
	public var rate : Double?
	public var id : String?
	public var release_date : Int?
	public var title : String?
	public var presale_flag : Int?
	public var age_category : String?
	public var genre_ids : Array<Genre_ids>?
    public var genre_name : String?
    public var description : String = ""


/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Movies_list = Movies.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Movies Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Movies]
    {
        var models:[Movies] = []
        for item in array
        {
            models.append(Movies(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Movies = Movies(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Movies Instance.
*/
	required public init?(dictionary: NSDictionary) {

		poster_path = dictionary[MOVIE_POSTER_PATH] as? String
		rate = dictionary[MOVIE_RATE] as? Double
		id = dictionary[MOVIE_ID] as? String
		release_date = dictionary[MOVIE_RELEASE_DATE] as? Int
		title = dictionary[MOVIE_TITLE] as? String
		presale_flag = dictionary[MOVIE_PRESALE_FLAG] as? Int
		age_category = dictionary[MOVIE_AGE_CATEGORY] as? String
        
        if let val = dictionary[MOVIE_DESCRIPTION] as? String
        {
            description = val
        }
        if (dictionary[MOVIE_GENRE_ID] != nil) { genre_ids = Genre_ids.modelsFromDictionaryArray(array: dictionary[MOVIE_GENRE_ID] as! NSArray)
            
            if (genre_ids?.count)! > 0
            {
                var name = ""
                let separator = " | "
                for i in 0..<genre_ids!.count
                {
                    name += genre_ids![i].name!
                    if i != genre_ids!.count - 1
                    {
                        name += separator
                    }
                }
                genre_name = name
            }
            else
            {
                genre_name = ""
            }
            
        }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.poster_path, forKey: MOVIE_POSTER_PATH)
		dictionary.setValue(self.rate, forKey: MOVIE_RATE)
		dictionary.setValue(self.id, forKey: MOVIE_ID)
		dictionary.setValue(self.release_date, forKey: MOVIE_RELEASE_DATE)
		dictionary.setValue(self.title, forKey: MOVIE_TITLE)
		dictionary.setValue(self.presale_flag, forKey: MOVIE_PRESALE_FLAG)
		dictionary.setValue(self.age_category, forKey: MOVIE_AGE_CATEGORY)
        dictionary.setValue(self.description, forKey: MOVIE_DESCRIPTION)

		return dictionary
	}

}
