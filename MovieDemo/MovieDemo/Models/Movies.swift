/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

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

		poster_path = dictionary["poster_path"] as? String
		rate = dictionary["rate"] as? Double
		id = dictionary["id"] as? String
		release_date = dictionary["release_date"] as? Int
		title = dictionary["title"] as? String
		presale_flag = dictionary["presale_flag"] as? Int
		age_category = dictionary["age_category"] as? String
        
        if let val = dictionary["description"] as? String
        {
            description = val
        }
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
        dictionary.setValue(self.description, forKey: "description")

		return dictionary
	}

}
