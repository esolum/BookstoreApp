//
//  Config.swift
//  Bookstore
//
//  Created by Erica Solum on 11/25/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

struct Config {
    static let appID = "P2FYXCR8D55JY"
    static let secret = "48f1cbd2-762b-e470-849f-766242a6b169"
    static let authorizeURL = "https://sandbox.dev.clover.com/oauth/authorize?client_id=\(Config.appID)&response_type=code"
    
    static let restCallURL = "https://sandbox.dev.clover.com/oauth/token?client_id={appId}&client_secret={appSecret}&code={codeUrlParam}"
    static var merchantID = ""
    static var employeeID = ""
    static var code = ""
    static var accessToken = ""
}
