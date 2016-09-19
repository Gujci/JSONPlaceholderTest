//
//  Models.swift
//  JSONPlaceholderTest
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import Foundation
import SwiftyJSON
import RESTAPI

//MARK: - Post data model
struct Post {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

//MARK: - JSONParseable
extension Post: JSONParseable {
    
    init(withJSON data: JSON) {
        userId = data["userId"].intValue
        id = data["id"].intValue
        title = data["title"].stringValue
        body = data["body"].stringValue
    }
}
