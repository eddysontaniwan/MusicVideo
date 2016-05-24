//
//  ViewController.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 5/18/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(videos: [Videos]){
        
        print(reachabilityStatus)
        
        
//        let alert = UIAlertController(title: "Notification", message: (result), preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "OK", style: .Default) {
//            action -> Void in
//            // do something if u want
//        }
//        
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
        
        self.videos = videos
        
        for item in videos{
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(index) name = \(video.vName)")
//        }
        
        // ==== OLD WAY
//        for var i = 0; i < videos.count; i++ {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
    }
}

