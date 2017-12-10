//
//  AppDelegate.swift
//  Bookstore
//
//  Created by Erica Solum on 11/22/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import GoConnector
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var authDelegate: AuthDelegate?
    var window: UIWindow?
    public var cloverConnector:ICloverGoConnector?
    public var cloverConnectorListener:CloverGoConnectorListener?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if Config.accessToken != "" {
            connectToCloverGoReader()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
    
    //Called when using UIApplication.shared to open link
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // parse url params to get access token
        extractInfoFromURL(url: url)
        return true
    }
    
    // FOR iOS versions below 10.0
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                     annotation: Any) -> Bool {
        extractInfoFromURL(url: url)
        return true
    }
    
    // MARK: - Helper Functions
    
    func extractInfoFromURL(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let components = components {
            if let queryItems = components.queryItems {
                for queryItem in queryItems {
                    switch queryItem.name {
                    case "merchant_id":
                        Config.merchantID = queryItem.value!
                    case "employee_id":
                        Config.employeeID = queryItem.value!
                    case "code":
                        Config.code = queryItem.value!
                    default:
                        "Query parameter not recognized: \(queryItem.name)"
                    }
                }
            }
        }
        getAccessToken()
        
    }
    func getAccessToken() {
        // Endpoint for REST call
        let endpoint: String = "https://sandbox.dev.clover.com/oauth/token?client_id=\(Config.appID)&client_secret=\(Config.secret)&code=\(Config.code)"
        Alamofire.request(endpoint)
            .responseJSON { response in
                // Handle JSON
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get token as JSON from API")
                    print("Error: \(response.result.error)")
                    self.authDelegate?.authFailed(message: "Couldn't connect to CloverGo system.")
                    return
                }
                if let token = json["access_token"] as? String {
                    print("Got our access token: \(token)")
                    Config.accessToken = token
                    self.connectToCloverGoReader()
                }
        }
    }
    
    func connectToCloverGoReader() {
        let config : CloverGoDeviceConfiguration = CloverGoDeviceConfiguration.Builder(apiKey: Config.appID, secret: Config.secret, env:   .sandbox).accessToken(Config.accessToken).allowDuplicateTransaction(true).allowAutoConnect(true).build()
        config.remoteApplicationID = "ericasolum.bookstore"
        
        cloverConnector = CloverGoConnector(config: config)
        cloverConnectorListener = CloverGoConnectorListener(cloverConnector: cloverConnector!)
        cloverConnectorListener?.viewController = self.window?.rootViewController
        cloverConnector?.addCloverGoConnectorListener(cloverConnectorListener: cloverConnectorListener!)
        
        //Set authentication delegate so Connect modal will be dismissed
        if let del = authDelegate {
            del.authCompleted()
        }
    }
}

