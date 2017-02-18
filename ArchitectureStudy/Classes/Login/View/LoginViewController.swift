//
//  LoginViewController.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 2. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var repositoryTextField: UITextField!
    @IBOutlet weak var accessTokenTextField: UITextField!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initialize() {
        self.presenter = LoginPresenter()
        self.accessTokenTextField.text = "67bcae216900713749355ca04bc4bc6bbce8b4f9"
        
        self.presenter.setUserName(userName: userNameTextField.text)
        self.presenter.setRepository(repository: repositoryTextField.text)
        self.presenter.setAccessToken(accessToken: accessTokenTextField.text)
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func valueChangedUserName(_ sender: Any) {
        self.presenter.setUserName(userName: userNameTextField.text)
    }
    
    @IBAction func valueChangedRepository(_ sender: Any) {
        self.presenter.setRepository(repository: repositoryTextField.text)
    }
    
    @IBAction func valueChangedAccessToken(_ sender: Any) {
        self.presenter.setAccessToken(accessToken: accessTokenTextField.text)
    }
    
    
}
