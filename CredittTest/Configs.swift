//
//  Configs.swift
//  CredittTest
//
//  Created by Piyush Kaklotar on 01/12/21.
//


import Foundation
import UIKit

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

// IMPORTANT: APP NAME
let APP_NAME = "Service Foods"
let APP_ID = "1413146875"
let APP_VERSION : String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
let APP_BUILD : String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)! // e.g. 1.1.0
let DEVICE_MODEL = UIDevice.current.model // e.g. iPhone 5
let SYSTEM_VERSION = UIDevice.current.systemVersion // The current version of the operating system. e.g. 9.0
let DEVICE_SIZE = UIScreen.main.bounds


extension UIViewController
{
    open override func awakeFromNib() {
        
        //to hide back title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func showAlert(titleStr:String = APP_NAME, messageStr : String)
    {
        let alert = UIAlertController(title: titleStr,
                                      message: messageStr,
                                      preferredStyle: .alert)
        
        let YesAction = UIAlertAction(title: "OK",
                                      style: .default)
        { (action: UIAlertAction!) -> Void in
            
        }
        alert.addAction(YesAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func handleError(errorResponse : HTTPURLResponse,response :[String : Any])
    {
        if (errorResponse.statusCode == 401)
        {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.showAlert(titleStr: "", messageStr: response["error"] as! String)
            })
            CATransaction.commit()
        }
        else if (errorResponse.statusCode == 403)
        {
            self.showAlert(titleStr: "", messageStr: response["error"] as! String)
        }
        else if (errorResponse.statusCode == 502)
        {
            self.showAlert(titleStr: "", messageStr: response["error"] as! String)
        }
        else if (errorResponse.statusCode == 504)
        {
            self.showAlert(titleStr: "", messageStr: response["error"] as! String)
        }
        else
        {
            self.showAlert(titleStr: "", messageStr: SOMETHING_WENT_ERROR_MESSAGE)
        }
    }
    
}

public extension String {
    
    var floatValue: Float {
        
        if self == "" { return 0.00 }
        return (self as NSString).floatValue
    }
    
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    func stringByAppendingPathComponent(_ path: String) -> String {
        let string = self as NSString
        
        return string.appendingPathComponent(path)
    }
    
    func hasString(_ string: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return self.range(of: string) != nil
        } else {
            return self.lowercased().range(of: string.lowercased()) != nil
        }
    }
    
    static func encodeToBase64(_ string: String) -> String {
        let data: Data = string.data(using: String.Encoding.utf8)!
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    static func decodeBase64(_ string: String) -> String {
        let data: Data = Data(base64Encoded: string as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func encodeToBase64() -> String {
        return String.encodeToBase64(self)
    }
    
    func decodeBase64() -> String {
        return String.decodeBase64(self)
    }
    
    func convertToNSData() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    func URLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    func removeWhiteSpacesFromString() -> String {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    func trim() -> String
    {
        var str=self.trimmingCharacters(in: .whitespaces)
        str = str.trimmingCharacters(in: .newlines)
        return str
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func getDayOfWeek()->String? {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date as Date)
        //return calendar.component(.day, from: date)
    }
    
    func convertToLocalTimeZone() -> Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.local
        let dt = formatter.date(from: self)
        if dt != nil
        {
            return dt!
        }
        else
        {
            return Date()
        }
    }
    
    func convertToDateStringForProfile() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.local
        let dt = formatter.date(from: self)
        
        if dt != nil
        {
            formatter.dateFormat = "MMMM yyyy"
            let strDt = formatter.string(from: dt!)
            return strDt
        }
        else
        {
            return ""
        }
    }
    
    
    func convertToDate() -> Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dt = formatter.date(from: self)
        if dt != nil
        {
            return dt!
        }
        else
        {
            return Date()
        }
    }
    
    func cleanPhoneNo() -> String
    {
        var strPhoneNo : String = self
        strPhoneNo = strPhoneNo.trim()
        strPhoneNo = strPhoneNo.replacingOccurrences(of: "-", with: "")
        strPhoneNo = strPhoneNo.replacingOccurrences(of: " ", with: "")
        strPhoneNo = strPhoneNo.replacingOccurrences(of: "(", with: "")
        strPhoneNo = strPhoneNo.replacingOccurrences(of: ")", with: "")
        strPhoneNo = strPhoneNo.replacingOccurrences(of: "_", with: "")
        
        return strPhoneNo
    }
}
