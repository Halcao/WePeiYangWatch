//
//  NewsInterfaceController.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/23.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit
import Foundation

let ROW_IN_PAGE = 12

class NewsInterfaceController: WKInterfaceController {
    var curPage = 1
    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var prevBtn: WKInterfaceButton!
    @IBOutlet var nextBtn: WKInterfaceButton!
    
    // 逻辑 小于等于1不能用
    @IBAction func prevClicked() {
        if curPage > 1 {
            curPage -= 1
            getDataWith(index: curPage)
            if curPage == 1 {
                prevBtn.setHidden(true)
            }
        }
    }
    
    @IBAction func nextClicked() {
        curPage += 1
        prevBtn.setHidden(false)
        getDataWith(index: curPage)
        table.scrollToRow(at: 0)
    }
    var models = Array<NewsModel>()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        table.setNumberOfRows(ROW_IN_PAGE, withRowType: "TableController")
        prevBtn.setHidden(true)
        getDataWith(index: 1)
        // Configure interface objects here.
    }

    func getDataWith(index:Int) {
        let url = URL(string: "http://open.twtstudio.com/api/v1/news/1/page/\(index)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("faild");
                return
            }
            
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    //dictionary就是json数据
                    let arr = dictionary["data"] as! Array<[String: AnyObject]>
                    self.models.removeAll()
                    for dic in arr {
                        let model = NewsModel(with: dic["subject"] as! String, index: dic["index"] as! Int)
                        self.models.append(model)
                    }
                    self.reloadData()
                }
            } catch _ {
            }

        }
        task.resume()
    }
    
    func reloadData() {
        for (index, model) in self.models.enumerated() {
            let cell = table.rowController(at: index) as! rowController
            cell.titleLabel.setText(model.title)
        }
    }
    
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        if models.isEmpty == false {
            pushController(withName: "NewsDetailController", context: models[rowIndex].index)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
