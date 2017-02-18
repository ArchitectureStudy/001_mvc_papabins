//
//  IssueCell.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 9..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateImageButton: UIButton!
    @IBOutlet weak var commentsImageView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
