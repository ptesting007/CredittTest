//
//	LanguageModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LanguageModel : NSObject, NSCoding{

	var data : [Languages]!
	var message : String!
	var success : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		data = [Languages]()
		if let dataArray = dictionary["data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = Languages(fromDictionary: dic)
				data.append(value)
			}
		}
		message = dictionary["message"] as? String
		success = dictionary["success"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if message != nil{
			dictionary["message"] = message
		}
		if success != nil{
			dictionary["success"] = success
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey :"data") as? [Languages]
         message = aDecoder.decodeObject(forKey: "message") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if success != nil{
			aCoder.encode(success, forKey: "success")
		}

	}

}


class Languages : NSObject, NSCoding{

    var languageName : String!
    var shortName : String!
    var isSelected : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        languageName = dictionary["language_name"] as? String
        shortName = dictionary["short_name"] as? String
        isSelected = false
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if languageName != nil{
            dictionary["language_name"] = languageName
        }
        if shortName != nil{
            dictionary["short_name"] = shortName
        }
        if isSelected != nil{
            dictionary["isSelected"] = isSelected
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         languageName = aDecoder.decodeObject(forKey: "language_name") as? String
         shortName = aDecoder.decodeObject(forKey: "short_name") as? String
         isSelected = false
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if languageName != nil{
            aCoder.encode(languageName, forKey: "language_name")
        }
        if shortName != nil{
            aCoder.encode(shortName, forKey: "short_name")
        }
        if isSelected != nil{
            aCoder.encode(isSelected, forKey: "isSelected")
        }
    }

}
