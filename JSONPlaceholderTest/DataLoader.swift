//
//  DataLoader.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import Foundation
import RESTAPI
import EventEmitter
import AppDependencies

//MARK: - Events
enum LoaderEvent: String, Event {
    case postsLoaded
    case detailedPostLoaded
}

//MARK: - DataLoader
final class DataLoader: EventEmitter {
    
    var listeners: Dictionary<String, Array<Any>>? = [:]
    var serverApi = API(withBaseUrl: "http://jsonplaceholder.typicode.com")
    
    fileprivate(set) var posts: [Post]? {
        didSet {
            DispatchQueue.main.async {
                self.emit(LoaderEvent.postsLoaded)
            }
        }
    }
    
    fileprivate(set) var detailedPost: Post? {
        didSet {
            DispatchQueue.main.async {
                self.emit(LoaderEvent.detailedPostLoaded)
            }
        }
    }
}

//MARK: - Functions
extension DataLoader {
    
    func loadPosts() {
        serverApi.get("/posts") { [weak self] (err, data: [Post]?) in
            guard err == nil else { return }
            self?.posts = data
        }
    }
    
    func loadDetailForPost(with id: Int) {
        serverApi.get("/posts/\(id)") { [weak self] (err, data: Post?) in
            guard err == nil else { return }
            self?.detailedPost = data
        }
    }
    
    func dropDetail() {
        detailedPost = nil
    }
}

//MARK: - Injectable
extension DataLoader: Injectable {
    
    static var id: String { return "loader" }
    
    static func create() -> DataLoader {
        return DataLoader()
    }
}
