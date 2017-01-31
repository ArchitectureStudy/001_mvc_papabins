//
//  IssueCommentCell.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

class IssueCommentCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
 
    override func awakeFromNib() {
        self.layer.cornerRadius = 8.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.af_cancelImageRequest()
        profileImageView.layer.removeAllAnimations()
        profileImageView.image = nil
    }
}
