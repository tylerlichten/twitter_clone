//
//  SelectedUserTweetsVC.swift
//  Twitter Clone
//
//  Created by Tyler Lichten on 5/17/16.
//  Copyright © 2016 Tyler Lichten. All rights reserved.
//

import UIKit

class SelectedUserTweetsVC: UITableViewController {
    
    var selectedTweet : Tweet!
    var twitterNetworkController : NetworkController!
    var allTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = selectedTweet.userName
        
        twitterNetworkController.fetchSelectedUserTimeline(selectedTweet.userName, completionHandler: { (results, error) -> () in
            if error == nil {
                self.allTweets = results!
                self.tableView.reloadData()
            } else {
                print("There was an error with the fetch")
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Selected_User_Tweet_Cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.allTweets[indexPath.row].text
        
        return cell
    }
}
