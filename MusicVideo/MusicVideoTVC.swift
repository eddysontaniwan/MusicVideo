//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 5/30/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.preferedFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferedFontChanged() {
        
        print("The preferred font has changed")
    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
            
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("Delete")
                }
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) {
                    action -> Void in
                    print("OK")
                    
                    // do something if you want
                    // alert.dismissViewControllerAnimated(true, completion:nil)
                }
                
                alert.addAction(OKAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
//        case WIFI: view.backgroundColor = UIColor.greenColor()
//        displayLabel.text = "Reachable with WIFI"
//        case WWAN: view.backgroundColor = UIColor.yellowColor()
//        displayLabel.text = "Reachable with Cellular"
        default:
//            view.backgroundColor = UIColor.greenColor()
            if videos.count > 1 {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    func runAPI() {
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
    }
    
    // Is called just as the object is about to be deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
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
        
        tableView.reloadData()
        
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier
        {
            if let indexpath = tableView.indexPathForSelectedRow {
                
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
                
            }
            
        }
    }
    

}
