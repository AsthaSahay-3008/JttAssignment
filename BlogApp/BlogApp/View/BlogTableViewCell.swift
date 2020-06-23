//
//  BlogTableViewCell.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

   @IBOutlet weak var nameLabel         : UILabel!
   @IBOutlet weak var designationLabel  : UILabel!
   @IBOutlet weak var timeLabel         : UILabel!
   @IBOutlet weak var detailsLabel      : UILabel!
   @IBOutlet weak var urLLabel          : UILabel!
   @IBOutlet weak var likesLabel        : UILabel!
   @IBOutlet weak var commentsLabel     : UILabel!
   @IBOutlet weak var profileImage      : UIImageView!
   @IBOutlet weak var mediaImage        : UIImageView!
   
    var viewModel :BlogTableViewCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 22.0
        profileImage.layer.borderWidth  = 1.0
        profileImage.layer.borderColor  = UIColor.gray.cgColor
        // Initialization code
    }
    
    func loadCell(_ model: BlogTableViewCellViewModel) {
        nameLabel.text          = model.displayName
        designationLabel.text   = model.displayDesignation
        timeLabel.text          = model.displayTime
        detailsLabel.text       = model.displayDetails
        if let mediaUrl = model.mediaUrl , let displayUrl = model.mediaUrl?.absoluteString
        {
            let attributeString = NSMutableAttributedString(string: displayUrl)
            attributeString.addAttribute(.link, value: mediaUrl, range: NSRange(location: 0, length: displayUrl.count))
            urLLabel.attributedText = attributeString
        } else {
            urLLabel.attributedText = nil
        }
        likesLabel.text         = model.displayLikes
        commentsLabel.text      = model.displayComments
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
