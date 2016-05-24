//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Tyler Lichten on 5/16/16.
//  Copyright © 2016 Tyler Lichten. All rights reserved.
//

import Foundation

class Tweet {
    
    var userName : String!
    var text : String!
    var userLocation : String!
    var userImgURLString : String!
    
    init(jsonDataDictionary : [String : AnyObject]) {
        //print(jsonDataDictionary)
        
        self.text = jsonDataDictionary["text"] as! String!
        //print(self.text)
        
        if let userDictionary = jsonDataDictionary["user"] as? [String : AnyObject] {
            self.userName = userDictionary["screen_name"] as! String
            self.userLocation = userDictionary["location"] as! String
            self.userImgURLString = userDictionary["profile_image_url"] as! String
        }
        //print(self.text)
        //print(self.userName)
        //print(self.userLocation)
        //print(userImgURLString)
    }
}