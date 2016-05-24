//
//  APIManager.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 5/18/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import Foundation

class APIManager {
    func loadData(urlString:String, completion: [Videos] -> Void) {
        
        // An ephemeral session has no persistent disk storage for cookies, cache or credentials.
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            if error != nil {
//                dispatch_async(dispatch_get_main_queue()) {
                    print(error!.localizedDescription)
//                }
            } else {
                // Added for JSONSerialization
                // print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                    Any type of string or value
                    NSJSONSerialization requires the Do / Try / Catch
                    Converts the NSData into a JSON Object and cast it to a Dictionary. */
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: .AllowFragments) as? JSONDictionary ,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                        
                        var videos = [Videos]()
                        for entry in entries {
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesApiManager - total count --> \(i)")
                        print(" ")
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(videos)
                            }
                        }
                        
//                        print(json)
//                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
//                        dispatch_async(dispatch_get_global_queue(priority, 0)){
//                            dispatch_async(dispatch_get_main_queue()) {
//                                completion(result: "JSONSerialization Successful")
//                            }
//                        }
                    }
                } catch {
//                    dispatch_async(dispatch_get_main_queue()){
                        print("error in NSJSONSerialization")
//                    }
                }
            }
        }
        task.resume()
    }
}