//
//  NewsModel.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/23.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit

class NewsModel: NSObject {
    var title: String!
    var index: Int!
    convenience init(with title: String, index: Int) {
        self.init()
        self.title = title
        self.index = index
    }
}
