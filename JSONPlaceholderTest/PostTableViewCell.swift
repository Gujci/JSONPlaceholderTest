//
//  PostTableViewCell.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postIdLabel: UILabel!
    
    func setup(with data: Post) -> UITableViewCell {
        
        postTitleLabel.text = data.title
        postIdLabel.text = "\(data.id)"
        
        return self
    }
}
