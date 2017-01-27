//
//  GPARowView.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/27.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit

class GPARowView: NSObject {
    @IBOutlet var label: WKInterfaceLabel!
    var model: M\!
    
    override init() {
        super.init()
        if let model = model {
            titleLabel.setText(model.title)
        }
    }
}
