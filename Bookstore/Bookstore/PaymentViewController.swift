//
//  PaymentViewController.swift
//  Bookstore
//
//  Created by Erica Solum on 11/25/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import GoConnector
import CloverGoReaderSDK
import clovergoclient

class PaymentViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    
    @IBOutlet weak var securityCodeField: UITextField!
    @IBOutlet weak var ccTextField: UITextField!
    
    @IBOutlet weak var expMonthField: UITextField!
    @IBOutlet weak var expYearField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        securityCodeField.delegate = self
        ccTextField.delegate = self
        expMonthField.delegate = self
        expYearField.delegate = self
    }
    
    // MARK: Text Field Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Button Actions
    @IBAction func exitPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func processPayment(_ sender: UIButton) {
        if let ccNum = ccTextField.text, let cvv = securityCodeField.text, let expYear = expYearField.text, let expMonth = expMonthField.text {
            //(UIApplication.shared.delegate as? AppDelegate)?.cloverConnectorListener?.viewController = self
            
            // execute a sale transaction
            if let cloverConnector = (UIApplication.shared.delegate as? AppDelegate)?.cloverConnector {
                let keyedCardData = CLVModels.Payments.KeyedCardData(cardNumber: ccNum, expirationDate: String("\(expMonth)\(expYear)"), cvv: cvv)
                cloverConnector.processKeyedTransaction(keyedCardData: keyedCardData)
            }
        }
        else {
            // Show the error label telling user to fill out all fields
            errorLabel.isHidden = false
        }
    }
}
