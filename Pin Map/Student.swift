//
//  Student.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/26/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import Foundation

struct Student {
    
    let fullName: String
    let location: String
    let mediaURL: String
    
    init(dictionary: [String: Any]) {
        let firstName = dictionary["firstName"] as! String
        let lastName = dictionary["lastName"] as! String
        self.fullName = "\(firstName) \(lastName)"
        self.location = dictionary["mapString"] as! String
        self.mediaURL = dictionary["mediaURL"] as! String
    }
}
