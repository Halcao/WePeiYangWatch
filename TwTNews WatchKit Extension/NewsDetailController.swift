//
//  NewsDetailController.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/23.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class NewsDetailController: WKInterfaceController, WCSessionDelegate{
    var index = 0
    
    @IBOutlet var imgView: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        guard let context = context else {
            return
        }
        
        index = context as! Int
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        getNewsContent()
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("when????")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("message:  \(message)")
        let data = message["data"] as! Data
        
        self.imgView.setImageData(data)
        print("fucking right")

    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("message:  \(message)")
        let data = message["data"] as! Data
        self.imgView.setImageData(data)
        print("fucking here")

    }
    
    
    func sendString(_ string: String) {
        if WCSession.default().isReachable {
            WCSession.default().sendMessage(["content" : string], replyHandler: { result in
                print(result)
              //  let data = result["data"] as! Data
                
             //   self.imgView.setImageData(data)
                print("hihihiihihi")
                
            }, errorHandler: { error in
                print(error)
            })
        }
    }
    
    
    func getNewsContent() {
        let url = URL(string: "http://open.twtstudio.com/api/v1/news/\(index)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("faild");
                return
            }
            
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    //dictionary就是json数据
                    let dic = dictionary["data"] as! [String: AnyObject]
                    let str = dic["content"] as! String
                    self.sendString(str)
                    
                    self.reloadData(with: str)
                }
            } catch _ {
            }
            
        }
        task.resume()

    }
    
    func reloadData(with str: String) {
        do{
            
            //let attrStr = try NSAttributedString(data: str.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)

            //contentLabel.setAttributedText(attrStr)
              //  contentLabel.sizeToFitHeight()

        }catch let error as NSError {
            print(error.localizedDescription)
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
