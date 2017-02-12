//
//  Client.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/9/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//


import UIKit


class Client {
    
    static let shared = Client()
    var session = URLSession.shared
    
    //==================================================
    // MARK: Udacity Functions
    //==================================================

func URLForUdacity(withPathExtension: String? = nil) -> URL {
    var components = URLComponents()
    components.scheme = Constants.Udacity.prefix
    components.host = Constants.Udacity.APIHost
    
    
    if withPathExtension != nil {
        var componentPath = Constants.Udacity.APIPath
        
        components.path = componentPath
    }
    
    return components.url! as URL
}
    
    func logout(completionHandlerForLoggingOut: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = NSURL(string: Constants.Udacity.sessionURL)
        var request = URLRequest(url: url as! URL)
        request.httpMethod = Constants.HTTPMethods.delete
        
        let task = self.session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard (error == nil) else {
                completionHandlerForLoggingOut(false, (error?.localizedDescription)!)
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = Range(5...data.count)
            
            let newData = NSString(data: data.subdata(in: range), encoding: String.Encoding.utf8.rawValue)
            
            guard let newdata = newData?.data(using: String.Encoding.utf8.rawValue) else {
                return
            }
            
            var parsedJSON: [String: Any]!
            do {
                parsedJSON = try JSONSerialization.jsonObject(with: newdata, options: .allowFragments) as! [String : Any]
            }
            catch {
                return
            }
            
            completionHandlerForLoggingOut(true, "")
        }
        task.resume()
    }

//==================================================
// MARK: HTTP Functions
//==================================================

func getStudentLocationsFromParse(completionHandlerForLocations: @escaping (_ success: Bool, _ error: String) -> Void) {
    
    let url = NSURL(string: Constants.Parse.fullParseLocationURL)
    var request = URLRequest(url: url as! URL)
    request.addValue(Constants.Parse.AppicationID, forHTTPHeaderField: Constants.Parse.httpHeaderID)
    request.addValue(Constants.Parse.APIKey, forHTTPHeaderField: Constants.Parse.httpHeaderAPI)
    
    let task = self.session.dataTask(with: request as URLRequest){(data,response,error) in
        
        guard error == nil else {
            completionHandlerForLocations(false,(error?.localizedDescription)!)
            return
        }
        
        guard let data = data else {
            return
        }
        
        var parsedJSON: [String: Any]!
        
        do {
            parsedJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
        }
        catch {
            return
        }
        
        guard let locations = parsedJSON["results"] as? [[String: Any]] else {
            return
        }
        
        Constants.Parse.studentLocations = locations
        completionHandlerForLocations(true, "")
    }
    task.resume()
}

func postForUdacity(urlAsString: String, httpMessageBody: String, completionHandlerForPost:@escaping (_ resultsDictionary :Any,_ errorString :String) -> Void) {
    
    let url = NSURL(string: urlAsString)
    var request = URLRequest(url: url as! URL)
    request.httpMethod = Constants.HTTPMethods.post
    request.addValue(Constants.Extensions.json, forHTTPHeaderField: "Accept")
    request.addValue(Constants.Extensions.json, forHTTPHeaderField: "Content-Type")
            request.httpBody = httpMessageBody.data(using: String.Encoding.utf8)
    
      let task = URLSession.shared.dataTask(with: request as URLRequest){(data,response,error) in
        
        var errorString = ""
        guard error == nil else {
            errorString = (error?.localizedDescription)!
            completionHandlerForPost("", errorString)
            return
        }
        
        guard let data = data else { return }
        
        let range = Range(5...data.count)
        
        let newData = NSString(data: data.subdata(in: range), encoding: String.Encoding.utf8.rawValue)
        
        guard let newdata = newData?.data(using: String.Encoding.utf8.rawValue) else
        {
            print("unable to convert to data")
            return
        }
        
        var parsedJSON: [String: Any]!
        do
        {
            parsedJSON = try JSONSerialization.jsonObject(with: newdata, options: .allowFragments) as! [String: Any]
        }
            
        catch
        {
            print("Can't parse the data")
            return
        }
        
        completionHandlerForPost(parsedJSON, errorString)
    }
    
    task.resume()
}

func getForUdacity(urlAsString: String, completionHandlerForGet: @escaping(_ resultsDictionary: Any, _ error: String) -> Void) {
    
    let url = NSURL(string: urlAsString)
    let request = URLRequest(url: url as! URL)
    let task = self.session.dataTask(with: request as! URLRequest){(data,response,error) in
        var errorString = ""
        guard error == nil else {
            errorString = (error?.localizedDescription)!
            completionHandlerForGet("", errorString)
            return
        }
        
        guard let data = data else {
            //handle error
            return
        }
        
        let range = Range(5...data.count)
        let newData = NSString(data: data.subdata(in: range), encoding: String.Encoding.utf8.rawValue)
        
        guard let newdata = newData?.data(using: String.Encoding.utf8.rawValue) else {
            return
        }
        
        var parsedJSON: [String : Any]!
        
        do{
            parsedJSON = try JSONSerialization.jsonObject(with: newdata, options: .allowFragments) as! [String : Any]
        }
        catch {
            print("Could not parse data in the get method.")
            return
        }
        
        completionHandlerForGet(parsedJSON, errorString)
        
    }
    task.resume()
}
}
