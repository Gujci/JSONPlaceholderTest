//
//  AppDelegate.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import UIKit
import AppDependencies

typealias App = Dependencies

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
}

//MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
