//
//  ViewController.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import UIKit

//MARK: - TableView state
enum PostListViewState {
    case Loading
    case Data([Post])
    case NoData
}

//MARK: - TableView data count
extension PostListViewState {
    
    var cellCount: Int {
        switch self {
        case .Loading:
            return 0
        case let .Data(posts):
            return posts.count
        case .NoData:
            return 0
        }
    }
}

//MARK: - TableView data at index
extension PostListViewState {
    
    func value(at row: Int) -> Post? {
        switch self {
        case .Loading, .NoData:
            return nil
        case let .Data(posts): let post = posts[row]
            return post
        }
    }
}

//MARK: - ViewController
class ViewController: UIViewController {
    
    fileprivate lazy var loader: DataLoader = App.sharedInstance.request()
    fileprivate var state: PostListViewState = .Loading {
        didSet {
            //TODO: - handle states normaly
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.on(LoaderEvent.postsLoaded) { [weak self] in
            guard let validPosts = self?.loader.posts else {
                self?.state = .NoData
                return
            }
            self?.state = .Data(validPosts)
        }
        
        loader.loadPosts()
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostTableViewCell else { fatalError("no celf for type") }
        guard let data = state.value(at: indexPath.row) else { fatalError("no data at index path") }
        return cell.setup(with: data)
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = state.value(at: indexPath.row) else { return }
        loader.loadDetailForPost(with: data.id)
    }
}
