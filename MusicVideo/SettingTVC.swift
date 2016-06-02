//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 6/2/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingTVC.preferedFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "Settings"
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        }
    }

    @IBAction func touchIDSecurity(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
        }
        else
        {
            defaults.setBool(false, forKey: "SecSetting")
        }
    }
    
    @IBAction func valueChanged(sender: UISlider) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
        
    }
    
    
    
    func preferedFontChanged() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    
}
