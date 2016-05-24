//
//  NetworkController.swift
//  Twitter Clone
//
//  Created by Tyler Lichten on 5/16/16.
//  Copyright © 2016 Tyler Lichten. All rights reserved.
//

import Foundation
import Social
import Accounts

class NetworkController {
    
    var usersTwitterAccount : ACAccount?
    
    init() {
        
    }
    
    func fetchUserTimeline(completionHandler : ([Tweet]?, String?) -> ()) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (accessGranted, error) -> Void in
            if error == nil {
                if accessGranted {
                    let allTwitterAccounts = accountStore.accountsWithAccountType(accountType)
                    
                    if allTwitterAccounts.isEmpty {
                        print("There are no Twitter accounts currently linked to this device.")
                    } else {
                        self.usersTwitterAccount = allTwitterAccounts.first as? ACAccount
                        
                        let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                        
                        let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
                        
                        twitterRequest.account = self.usersTwitterAccount
                        twitterRequest.performRequestWithHandler({ (data, response, error) -> Void in
                            if error == nil {
                                switch response.statusCode {
                                case 200...299:
                                    print("Good status code: \(response.statusCode)")
                                    
                                    //print(data.description)
                                    
                                    do {
                                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                                        
                                        if let jsonDataArray = json as? [AnyObject] {
                                            var allTweets = [Tweet]()
                                            for object in jsonDataArray {
                                                if let jsonDataDictionary = object as? [String : AnyObject]{
                                                    let currentTweet = Tweet(jsonDataDictionary: jsonDataDictionary)
                                                    allTweets.append(currentTweet)
                                                }
                                            }
                                            
                                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in completionHandler(allTweets, nil)
                                            })
                                        }
                                    } catch {
                                        print("error serializing JSON: \(error)")
                                    }
                                case 400...499:
                                    print("Bad status code: \(response.statusCode)")
                                default:
                                    print("User hit default case")
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
    func fetchSelectedUserTimeline(userName: String, completionHandler : ([Tweet]?, String?) -> ()) {
        
        let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(userName)")
        
        let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
        
        twitterRequest.account = self.usersTwitterAccount
        twitterRequest.performRequestWithHandler({ (data, response, error) -> Void in
            if error == nil {
                switch response.statusCode {
                case 200...299:
                    print("Good status code: \(response.statusCode)")
                    
                    //print(data.description)
                    
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        
                        if let jsonDataArray = json as? [AnyObject] {
                            var allTweets = [Tweet]()
                            for object in jsonDataArray {
                                if let jsonDataDictionary = object as? [String : AnyObject]{
                                    let currentTweet = Tweet(jsonDataDictionary: jsonDataDictionary)
                                    allTweets.append(currentTweet)
                                }
                            }
                            
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in completionHandler(allTweets, nil)
                            })
                        }
                    } catch {
                        print("error serializing JSON: \(error)")
                    }
                case 400...499:
                    print("Bad status code: \(response.statusCode)")
                default:
                    print("User hit default case")
                }
            }
        })
    }
}

