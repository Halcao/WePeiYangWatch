//
//  rowController.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/23.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit

class rowController: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    var model: NewsModel!
    
    override init() {
        super.init()
        if let model = model {
            titleLabel.setText(model.title)
        }
    }
}
