//
//  ConnectViewController.swift
//  Bookstore
//
//  Created by Erica Solum on 11/29/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, AuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Action
    @IBAction func connectToCloverGo(_ sender: UIButton) {
        if Config.accessToken == "" {
            if let url = URL(string: Config.authorizeURL) {
                
                if UIApplication.shared.canOpenURL(url as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url as URL, options: [:], completionHandler: { (success) in
                            if !success {
                                self.authFailed(message: "Couldn't connect to CloverGo system at this time.")
                            }
                        })
                    } else {
                        // Fallback on earlier versions
                        let success = UIApplication.shared.openURL(url as URL)
                        if !success {
                            self.authFailed(message: "Can't connect to CloverGo system at this time.")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Auth Delegate Method
    func authCompleted() {
        self.dismiss(animated: true, completion: nil)
    }
    func authFailed(message: String) {
        let alert = UIAlertController(title: "Uh-Oh", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Bummer dude", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
