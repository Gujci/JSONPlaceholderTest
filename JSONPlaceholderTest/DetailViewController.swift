//
//  DetailViewController.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    fileprivate lazy var loader: DataLoader = App.sharedInstance.request()
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.on(LoaderEvent.detailedPostLoaded) {  [weak self] in
            guard let _ = self?.loader.detailedPost else { return }
            self?.setup()
        }
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        loader.dropDetail()
    }
    
    private func setup() {
        navigationItem.title = loader.detailedPost?.title
        bodyTextView.text = loader.detailedPost?.body
    }
}
