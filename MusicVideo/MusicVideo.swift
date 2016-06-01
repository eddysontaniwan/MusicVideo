//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Eddyson Tan on 5/18/16.
//  Copyright © 2016 Eddyson Tan. All rights reserved.
//

import Foundation

class Videos {
    
    
    var vRank = 0
    
    // Data Encapsulation
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    init(data: JSONDictionary) {
        //If we do not initialize all property we will get error message
        //Return from initializer without initializing all stored properties
        
        // ---------------- video name ----------------
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        } else {
            // You may not always get data back from JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = ""
        }
        
        // ---------------- video Rights ---------------- 
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
            self._vRights = vRights
        } else {
            _vRights = ""
        }
        
        // ---------------- video Price ----------------
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        // ---------------- The video image ----------------
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // ---------------- video Artist ----------------
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        // ---------------- The video url ----------------
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        // ---------------- video imid ----------------
        if let imid = data["id"] as? JSONDictionary,
            imidAtt = imid["attributes"] as? JSONDictionary,
            vImid = imidAtt["im:id"] as? String {
            self._vImid = vImid
        } else {
            _vImid = ""
        }
        
        // ---------------- video Genre ----------------
        if let genre = data["category"] as? JSONDictionary,
            genreAtt = genre["attributes"] as? JSONDictionary,
            vGenre = genreAtt["term"] as? String {
            self._vGenre = vGenre
        } else {
            _vGenre = ""
        }
        
        // ---------------- video linkToItunes ----------------
        if let video = data["id"] as? JSONDictionary,
            vLinkToiTunes = video["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        } else {
            _vLinkToiTunes = ""
        }
        
        // ---------------- video releaseDate ----------------
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            relDate = releaseDate["attributes"] as? JSONDictionary,
            vReleaseDte = relDate["label"] as? String {
            self._vReleaseDte = vReleaseDte
        } else {
            _vReleaseDte = ""
        }
    }
}