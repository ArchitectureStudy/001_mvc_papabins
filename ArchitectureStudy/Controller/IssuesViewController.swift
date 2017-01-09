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
    
    var dataSource: Issues = Issues()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateIssues),
                                               name: Issues.notificationOfNewIssues,
                                               object: nil)
        dataSource.loadIssues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateIssues() {
        tableview.reloadData()
    }
}

extension IssuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IssueCell = (tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueCell)!
        
        let issue = dataSource.issues[indexPath.row]
        cell.titleLabel.text = issue.title
        if issue.state == "open" {
            cell.stateImageButton.isSelected = false
        }
        else if issue.state == "closed" {
            cell.stateImageButton.isSelected = true
        }
        return cell
    }
}
