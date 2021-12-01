//
//  ConstantStrings.swift
//  CredittTest
//
//  Created by Piyush Kaklotar on 01/12/21.
//

import Foundation
import UIKit

let INTERNET_ERROR_MESSAGE              = "No Internet Available"
let SOMETHING_WENT_ERROR_MESSAGE        = "Something Went Wrong"

let NO_LOADER                           = "NoLoader"

let COMMON_ERROR_MESSAGE                = "Something went wrong, Please try again later."
let INVALID_RESPONSE_MESSAGE            = "Invalid response."
let INVALID_API_RESPONSE_MSG            = "The API is currently unavailable and may be down for maintenance, please wait a few minutes and try again. If the problem persists, please contact support."


//MARK:- ------------*****------------
//MARK: Web services
#if DEBUG
    //Development
    let SER_BaseUrl                 = "http://111.118.214.237:4050/v11/unAuthRoutes/"
    let SER_HOST                    = "111.118.214.237:4050"
    

#elseif STAGING
    //UAT
    let SER_BaseUrl                 = "http://111.118.214.237:4050/v11/unAuthRoutes/" //Live
    let SER_HOST                    = "111.118.214.237:4050"

#else
    // for live
    let SER_BaseUrl                 = "http://111.118.214.237:4050/v11/unAuthRoutes/" //Live
    let SER_HOST                    = "111.118.214.237:4050"

#endif

let SER_LANGUAGE                    = SER_BaseUrl + "getNewLanguage"
