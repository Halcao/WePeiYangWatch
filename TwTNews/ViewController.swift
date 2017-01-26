//
//  ViewController.swift
//  TwTNews
//
//  Created by Halcao on 2017/1/23.
//  Copyright © 2017年 Halcao. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, UIWebViewDelegate {
    let webView = UIWebView()
    let imgView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = self.view.bounds
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        self.view.addSubview(webView)
         imgView.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        self.view.addSubview(imgView)
        webView.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("iphone when????")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let str = message["content"] as! String
        // let webView = UIWebView()
        DispatchQueue.main.sync {
         webView.loadHTMLString(str, baseURL: nil)
        
       // performSelector(onMainThread: #selector(ViewController.test), with: nil, waitUntilDone: !webView.isLoading)
    /*     let size = webView.bounds.size
         let width = size.width
         let height = size.height
         let offset = webView.scrollView.contentOffset
         webView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
         var contentHeight = webView.scrollView.contentSize.height
         var images = Array<UIImage>()
         while contentHeight > 0 {
         UIGraphicsBeginImageContext(size)
         webView.layer.render(in: UIGraphicsGetCurrentContext()!)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndPDFContext()
         images.append(image!)
         let offsetY = webView.scrollView.contentOffset.y
         webView.scrollView.setContentOffset(CGPoint(x: 0,y:offsetY + height), animated: false)
         contentHeight -= height
         }
         webView.scrollView.setContentOffset(offset, animated: false)
         UIGraphicsBeginImageContext(webView.scrollView.contentSize)
         for (index, image) in images.enumerated() {
         image.draw(in: CGRect(x: CGFloat(0), y: height*CGFloat(index), width: width, height: height))
         }
         let full = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         //let data = NSData(data: Data()
        let data = UIImagePNGRepresentation(full!)! as Data
//        let data1 = UIImagePNGRepresentation(images[0])
        //UserDefaults.standard.setValue(data!, forKey: "WEBVIEW_IMAGE")
         replyHandler(["data" : data])
 */
        }
    }
    
    func test() {
    
        let size = webView.bounds.size
        let width = size.width
        let height = size.height
        let offset = webView.scrollView.contentOffset
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        var contentHeight = webView.scrollView.contentSize.height
        var images = Array<UIImage>()
        while contentHeight > 0 {
            UIGraphicsBeginImageContext(size)
            webView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndPDFContext()
            images.append(image!)
            let offsetY = webView.scrollView.contentOffset.y
            webView.scrollView.setContentOffset(CGPoint(x: 0,y:offsetY + height), animated: false)
            contentHeight -= height
        }
        webView.scrollView.setContentOffset(offset, animated: false)
        UIGraphicsBeginImageContext(webView.scrollView.contentSize)
        for (index, image) in images.enumerated() {
            image.draw(in: CGRect(x: CGFloat(0), y: height*CGFloat(index), width: width, height: height))
        }
        let full = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //let data = NSData(data: Data()
        let data = UIImagePNGRepresentation(full!)! as Data
        
       // WCSession.default().sendMessage(["data" : data], replyHandler: nil, errorHandler: nil)

    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let size = webView.bounds.size
        let width = size.width
        let height = size.height
        let offset = webView.scrollView.contentOffset
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        var contentHeight = webView.scrollView.contentSize.height
        var images = Array<UIImage>()
        while contentHeight > 0 {
            UIGraphicsBeginImageContext(size)
            webView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndPDFContext()
            images.append(image!)
            let offsetY = webView.scrollView.contentOffset.y
            webView.scrollView.setContentOffset(CGPoint(x: 0,y:offsetY + height), animated: false)
            contentHeight -= height
        }
        webView.scrollView.setContentOffset(offset, animated: false)
        UIGraphicsBeginImageContext(webView.scrollView.contentSize)
        for (index, image) in images.enumerated() {
            image.draw(in: CGRect(x: CGFloat(0), y: height*CGFloat(index), width: width, height: height))
        }
        let full = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //let data = NSData(data: Data()
       // let data = UIImagePNGRepresentation(full!)! as Data
        let data = UIImagePNGRepresentation(images[0].scaleImage(scaleSize: 0.3))! as Data
        self.imgView.image = UIImage(data: data)
        WCSession.default().sendMessage(["data" : data], replyHandler: { result in
            print("i know received")
        
        }, errorHandler: nil)
        //WCSession.default().sendMessage(["data" : data], replyHandler: nil, errorHandler: nil)
    }
}

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}

