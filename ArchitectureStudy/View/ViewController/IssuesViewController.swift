//
//  IssuesViewController.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 9..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit
import Foundation

class IssuesViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var presenter: IssuesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = IssuesPresenter(delegate: self)
        
        self.presenter.loadIssues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as IssueDetailViewController:
            guard let issue = sender as? Issue else {
                return
            }
            viewController.title = "#\(issue.number)"
            
            
        default: break
        }
        
    }
}

extension IssuesViewController: IssuesPresensterProtocol {
    func didFinishLoadIssues() {
        tableview.reloadData()
    }
}

extension IssuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IssueCell = (tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueCell)!
        
        let issue = presenter.dataSource.issues[indexPath.row]
        cell.titleLabel.text = issue.title
        switch issue.state {
        case .open:
                cell.stateImageButton.isSelected = false
        case .closed:
            cell.stateImageButton.isSelected = true
        }
        if issue.comments > 0 {
            cell.commentsImageView.isHidden = false
            cell.commentsLabel.isHidden = false
            cell.commentsLabel.text = String(issue.comments)
        }
        else {
            cell.commentsImageView.isHidden = true
            cell.commentsLabel.isHidden = true
        }
        return cell
    }
}

extension IssuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = presenter.dataSource.issues[indexPath.row]
        self.performSegue(withIdentifier: "Show", sender:  issue)
    }
}

