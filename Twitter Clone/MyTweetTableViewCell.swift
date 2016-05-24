//
//  MyTweetTableViewCell.swift
//  Twitter Clone
//
//  Created by Tyler Lichten on 5/17/16.
//  Copyright © 2016 Tyler Lichten. All rights reserved.
//

import UIKit

class MyTweetTableViewCell: UITableViewCell {

    @IBOutlet var tweetImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var tweetText: UILabel!
    @IBOutlet var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
