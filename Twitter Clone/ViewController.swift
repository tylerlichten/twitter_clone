//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Tyler Lichten on 5/16/16.
//  Copyright © 2016 Tyler Lichten. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var allTweets = [Tweet]()
    
    var twitterNetworkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    
        twitterNetworkController.fetchUserTimeline { (results, error) -> () in
            if error == nil {
                self.allTweets = results!
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("My_Tweet_cell", forIndexPath: indexPath) as! MyTweetTableViewCell

        cell.tweetText.text = self.allTweets[indexPath.row].text
        cell.userName.text = self.allTweets[indexPath.row].userName
        cell.location.text = self.allTweets[indexPath.row].userLocation
        
        let userImageURLString = self.allTweets[indexPath.row].userImgURLString
        let userImageURL = NSURL(string: userImageURLString)
        let userImageData = NSData(contentsOfURL: userImageURL!)
        let userImage = UIImage(data: userImageData!)
        
        cell.tweetImageView.image = userImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedUserVC = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedUserTweetsVC") as! SelectedUserTweetsVC
        
        selectedUserVC.twitterNetworkController = self.twitterNetworkController
        selectedUserVC.selectedTweet = self.allTweets[indexPath.row]
        
        self.navigationController?.pushViewController(selectedUserVC, animated: true)
    }
}

