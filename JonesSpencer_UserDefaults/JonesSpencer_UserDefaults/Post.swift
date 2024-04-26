//  Post.swift
//  JonesSpencer_TableViewIntro
//  Created by Spencer Jones on 4/17/24.

import Foundation
import UIKit

class Post {
    
    // MARK: Stored Properties
    var subreddit: String
    var author: String
    var title: String
    var thumbnail: UIImage!
    
    // MARK: Computed Properties
    // Adds reddits u/ infront of the authors name
    var formattedAuthor: String {
        let authorString = "u/\(author)"
        return authorString
    }
    
    // MARK: Initalizer
    init(subreddit: String, author: String, title: String, thumbnailString: String) {
        self.subreddit = subreddit
        self.author = author
        self.title = title
        
        // Download thumbnail Image
        if let url = URL(string: thumbnailString) {
            
            do {
                let data = try Data(contentsOf: url)
                self.thumbnail = UIImage(data: data)
            }
            catch { print(error.localizedDescription) }
        }
    }
}
