

import Foundation


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

		poster_path = dictionary["poster_path"] as? String
		rate = dictionary["rate"] as? Double
		id = dictionary["id"] as? String
		release_date = dictionary["release_date"] as? Int
		title = dictionary["title"] as? String
		presale_flag = dictionary["presale_flag"] as? Int
		age_category = dictionary["age_category"] as? String
        if (dictionary["genre_ids"] != nil) { genre_ids = Genre_ids.modelsFromDictionaryArray(array: dictionary["genre_ids"] as! NSArray)
            
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

		dictionary.setValue(self.poster_path, forKey: "poster_path")
		dictionary.setValue(self.rate, forKey: "rate")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.release_date, forKey: "release_date")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.presale_flag, forKey: "presale_flag")
		dictionary.setValue(self.age_category, forKey: "age_category")

		return dictionary
	}

}
