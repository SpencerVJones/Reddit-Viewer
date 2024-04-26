//  RedditTableViewCell.swift
//  JonesSpencer_UserDefaults
//  Created by Spencer Jones on 4/21/24.

import UIKit

class RedditTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet var tableImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var user: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
