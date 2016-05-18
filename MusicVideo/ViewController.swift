//
//  ViewController.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 5/18/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(result:String){
        
        let alert = UIAlertController(title: "Notification", message: (result), preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            // do something if u want
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

