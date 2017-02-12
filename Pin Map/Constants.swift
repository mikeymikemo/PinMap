//
//  Constants.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/9/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Udacity {
        
        static let prefix = "https://"
        static let APIHost = "www.udacity.com"
        static let APIPath = "/api"
        static let session = "/session"
        static let users = "/users/{userID}"
        static var sessionID = "sessionID"
        static var firstName = "firstName"
        static var lastName = "lastName"
        static let sessionURL = "https://www.udacity.com/api/session"
        static var userID = ""
        static let userDetailsURL = "https://www.udacity.com/api/users/\(Constants.Udacity.userID)"
    }

    struct Parse {
        
        static let prefix = "https://"
        static let httpHeaderID = "X-Parse-Application-Id"
        static let httpHeaderAPI = "X-Parse-REST-API-Key"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let AppicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIHost = "parse.udacity.com"
        static let APIPath = "/parse/classes/StudentLocation"
        static let objectID = "/{objectID}"
        static let limit = "limit"
        static let skip = "skip"
        static let whereKey = "where"
        static let fullParseLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt"
        static var studentLocations: [[String:Any]]!
    }
    
    struct HTTPMethods {
        
        static let post = "POST"
        static let get = "GET"
        static let delete = "DELETE"
    }
    
    struct Extensions {
        static let json = "application/json"
    }
}
