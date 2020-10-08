//
//  LoginViewController.swift
//  Twitter
//
//  Created by Joseph Miller on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if user is logged in
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            // go directly to home screen if logged in
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        print(sender.titleLabel!.text!)
        let tokenUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: tokenUrl, success: {
            // persist user login
            UserDefaults.standard.setValue(true, forKey: "userLoggedIn")
            // go to home screen on successful login
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            // on login failure
            print("Could not log in!")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
