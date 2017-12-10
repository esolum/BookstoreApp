//
//  AuthDelegate.swift
//  Bookstore
//
//  Created by Erica Solum on 11/29/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

protocol AuthDelegate {
    func authCompleted()
    func authFailed(message: String)
}
