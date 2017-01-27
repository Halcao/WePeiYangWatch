//
//  GPAHelper.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/27.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit

class GPAHelper: NSObject {
    private static let sharedInstance = GPAHelper()
    private override init() {}
    var terms = [Term]()

    static var shared: GPAHelper{
        return self.sharedInstance
    }

    func getTerm() -> [Term] {
        if terms.count == 0 {
            
        }
        return terms
    }
    
    
}

struct Term {
    var classes = [MyClass]()
    var name = ""
    var aveGPA = 0.0
    var aveScore = 0.0
    var totalScore = 0.0
}

struct MyClass {
    var name = ""
    var grade = 0.0
    var score = 0.0
    init(with name: String, grade: Double, score: Double) {
        self.name = name
        self.grade = grade
        self.score = score
    }
}
