//
//  IssueDetailViewController.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

private let reuseIdentifier = "CommentCell"

class IssueDetailViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentInputTextField: UITextField!
    @IBOutlet weak var inputViewBottomLayoutConstraint: NSLayoutConstraint!
    
    var issueNumber: String!
    var presenter: IssueDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initialize() {
        
        self.title = "#\(issueNumber!)"
        sendButton.layer.cornerRadius = 5.0
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedKeyboard(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.presenter = IssueDetailPresenter(delegate: self, number: issueNumber)
        self.presenter.loadIssue()
        self.presenter.loadComments()
    }
    
    @IBAction func createCommentButtonAction(_ sender: Any) {
        guard let comment = commentInputTextField.text else {
            return
        }
        if comment.characters.count > 1 {
            self.presenter.createComments(comment: commentInputTextField.text!);
        }
    }
    
    @objc func onChangedKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardInfo = userInfo.keyboardInfo()
        let hidden = keyboardInfo.endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        UIView.animate(withDuration: keyboardInfo.duration, delay: 0, options: keyboardInfo.animationOptions, animations: {
            self.inputViewBottomLayoutConstraint.constant = hidden ? 0 : keyboardInfo.endFrame.size.height
        }, completion: nil)
    }
    
    @IBAction func backgroundTapGestureAction(_ sender: Any) {
        self.commentInputTextField.resignFirstResponder()
    }
    
}

extension IssueDetailViewController: IssueDetailPresenterDelegate {
    func didFinishLoadIssue() {
        collectionView.reloadData()
    }
    
    func didFinishLoadComments() {
        collectionView.reloadData()
    }
    
    func didCreatedComment(isSuccess: Bool) {
        if isSuccess {
            self.presenter.loadComments()
            self.commentInputTextField.text = ""
            self.commentInputTextField.resignFirstResponder()
        }
    }
}

// MARK: UICollectionViewDataSource
extension IssueDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dataSource.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "IssueDetailHeaderView",
                                                                             for: indexPath) as! IssueDetailHeaderView
            
            if let issue = presenter.dataSource.issue {
                headerView.titleLabel.text = issue.title
                headerView.issueInfoLabel.text = issue.user.login
                headerView.issueBodyTextView.text = issue.body
                
                let size = headerView.profileImageView.frame.size
                headerView.profileImageView.af_setImage(
                    withURL: URL(string: issue.user.avatarUrl!)!,
                    placeholderImage: nil,
                    filter: AspectScaledToFillSizeCircleFilter(size: size),
                    imageTransition: .crossDissolve(0.3)
                )
            }
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IssueCommentCell
        
        let comment = presenter.dataSource.comments[indexPath.row]
        let createdDate = comment.createdAt!
        cell.infoLabel.text = "\(comment.user.login!) \(createdDate))"
        cell.bodyTextView.text = comment.body
        
        if let avatarurl = comment.user.avatarUrl {
            let size = cell.profileImageView.frame.size
            cell.profileImageView.af_setImage(
                withURL: URL(string: avatarurl)!,
                placeholderImage: nil,
                filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0),
                imageTransition: .crossDissolve(0.3)
            )
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension IssueDetailViewController: UICollectionViewDelegate {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
