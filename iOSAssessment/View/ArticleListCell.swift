//
//  ArticleListCell.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
         Support Right To Left. Setting text alignment  based on Layout Direction
         */
        let attribute = self.semanticContentAttribute
        let layoutDirection = UIView.userInterfaceLayoutDirection(for: attribute)
        if layoutDirection == .rightToLeft {
            self.titleLabel.textAlignment = .right
            self.contentLabel.textAlignment = .right
        }
        else{
            self.titleLabel.textAlignment = .left
            self.contentLabel.textAlignment = .left
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
