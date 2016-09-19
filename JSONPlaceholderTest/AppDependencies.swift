//
//  AppDependencies.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import Foundation

typealias App = AppDependencies

//MARK: - Dependency protocolts
protocol Injectable: class {
    static var id: String {get}
    static func create() -> Self
}

//MARK: - Dependencies
class AppDependencies {
    
    static let sharedInstance = AppDependencies()
    fileprivate var injectables: [String: Injectable] = [:]
}

//MARK: -  Dependency management
extension AppDependencies {
    
    func request<T: Injectable>() -> T {
        return injectables[T.id] as? T ?? new()
    }
    
    func new<T: Injectable>() -> T {
        let newModule = T.create()
        injectables[T.id] = newModule
        return newModule
    }
}
