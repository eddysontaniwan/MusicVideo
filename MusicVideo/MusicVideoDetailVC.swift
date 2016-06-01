//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 6/1/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    var videos:Videos!
    
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            videoImage.image = UIImage(named: "no-image")
        }
    }

}
