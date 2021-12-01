//
//  CommonMethod.swift
//  CredittTest
//
//  Created by Piyush Kaklotar on 01/12/21.
//

import UIKit
import Alamofire
import SVProgressHUD

class CommonMethod: NSObject {

    static var loaderCount : Int! = 0
    
    private static var Manager: Alamofire.SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        
        let manager = Alamofire.SessionManager(
            configuration: configuration
        )
        return manager
    }()
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func callAPI(url:String,parameter: [String : Any]?,loaderString:String?, httpMethod : HTTPMethod = .post, completionHandler: @escaping (HTTPURLResponse?,Any?, Bool, Any?)->Swift.Void) {
        if !isConnectedToInternet()
        {
            CommonMethod.showAlert(message: "No internet connection")
            return
        }
        
        if loaderString != NO_LOADER {
            if loaderCount == 0 {
                showLoader()
            }
            loaderCount = loaderCount + 1
        }
        
        let url = url.URLEncode()
        
        
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["Host"] = SER_HOST
        
        let hed : [String : String] = headers
        
        URLCache.shared.removeAllCachedResponses()
        Manager.request(url, method: httpMethod , parameters: parameter, encoding: JSONEncoding.default, headers: hed)
            .validate(statusCode: 200..<500)
            //, "text/plain", "text/html"
            .validate(contentType: ["application/json"]).responseJSON { res in
                hideLoader()
            
            if res.result.isSuccess
            {
                if res.response?.statusCode == 200
                {
                    if res.result.value != nil && !(res.result.value is NSNull) {
                        completionHandler(res.response!,res.result.value!,true,nil)
                    }
                    else {
                        completionHandler(res.response!,res.result.value!,false,nil)
                    }
                }
                else if res.response?.statusCode == 204
                {
                    completionHandler(res.response!,res.result.value!,true,nil)
                    
                }
                else if res.response?.statusCode == 409
                {
                    completionHandler(res.response!,res.result.value!,true,nil)
                }
                else if res.response?.statusCode == 401
                {
                    completionHandler(res.response!,res.result.value!,false,nil)
                }
                else if res.response?.statusCode == 422 || res.response?.statusCode == 400
                {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    let resDictAuth : [String : AnyObject] = res.result.value as! Dictionary
                    showAlert(message: resDictAuth["error"] as? String ?? COMMON_ERROR_MESSAGE)
                }
                else {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if res.result.value != nil && !(res.result.value is NSNull) {
                        let resDictAuth : [String : AnyObject] = res.result.value as! Dictionary
                        showAlert(message: resDictAuth["error"] as? String ?? COMMON_ERROR_MESSAGE)
                    } else {
                        showAlert(message: INVALID_API_RESPONSE_MSG) //INVALID_RESPONSE_MESSAGE)
                    }
                    completionHandler(res.response!,res.result.value!,true,nil)
                    
                }
            }
            else
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                if res.response?.statusCode == 409
                {
                    completionHandler(res.response!,nil,true,nil)
                }
                else {
                    print(res.error!)
                    guard res.error == nil || res.response == nil else {
                        // handle error (including validate error) here, e.g.
                        if res.response?.statusCode == 1005 {
                            // handle 1005 here
                            showAlert(message: (res.error?.localizedDescription)!)
                        }
                        else
                        {
                            showAlert(message: (res.error?.localizedDescription)!)
                        }
                         completionHandler(res.response!,nil,true,nil)
                        return
                    }
                    showAlert(message: COMMON_ERROR_MESSAGE)
                }
            }
        }
        
    }
    
    class func showLoader(message:String = "") {
        if !SVProgressHUD.isVisible()
        {
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.black)
        }
    }
    
    class func hideLoader() {
        loaderCount = loaderCount - 1  <= 0 ? 0 : loaderCount - 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if loaderCount > 0 {
                return
            }
            SVProgressHUD.dismiss()
        }
    }
    
    class func showAlert (title : String = APP_NAME, message: String)
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"okay" , style: .default) { action in
                
            })
            let currentTopVC: UIViewController? = self.currentTopViewController()
            currentTopVC!.modalPresentationStyle = .fullScreen
            currentTopVC!.present(alert, animated: true, completion: nil)
    }
    
    class func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? =  UIApplication.shared.keyWindow?.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
}
