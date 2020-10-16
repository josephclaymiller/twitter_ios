//
//  tweetCell.swift
//  Twitter
//
//  Created by Joseph Miller on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        favorited ? favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal) : favButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if retweeted {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        // toggle favorited status of tweet
        if favorited {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed \(error)")
            })
        } else {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: UIButton) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
    }
    
}
