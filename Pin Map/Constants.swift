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
        static let httpMessageBodyForUpdatingList = "{\"uniqueKey\": \"\(Constants.Udacity.userID)\", \"firstName\": \"\(Constants.Udacity.firstName)\", \"lastName\": \"\(Constants.Udacity.lastName)\",\"mapString\": \"\(Constants.Map.enteredLocation!)\", \"mediaURL\": \"\(Constants.Map.enteredURL!)\",\"latitude\": \(Constants.Map.latitude!), \"longitude\": \(Constants.Map.longitude!)}"
        static let httpMessageBodyForUpdate = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
    }

    struct Parse {
        
        static let prefix = "https://"
        static let httpHeaderID = "X-Parse-Application-Id"
        static let httpHeaderAPI = "X-Parse-REST-API-Key"
        static let contentType = "application/json"
        static let forHTTPHeaderField = "Content-Type"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let AppicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIHost = "parse.udacity.com"
        static let APIPath = "/parse/classes/StudentLocation"
        static var objectID = ""
        static let limit = "limit"
        static let skip = "skip"
        static let whereKey = "where"
        static let fullParseLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt"
        static var studentLocations: [[String:Any]]!
        static let studentLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation"
        static let updateStudentLocationURL = "https://parse.udacity.com/parse/classes/StudentLocation/\(Constants.Parse.objectID)"
    }
    
    struct Map {
        static var enteredLocation: String! = ""
        static var latitude: Double?
        static var longitude: Double?
        static var enteredURL: String! = ""
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
