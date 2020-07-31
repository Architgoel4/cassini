//
//  DemoURL.swift
//  Cassini
//
//  Created by Goel, Archit on 13/12/17.
//  Copyright © 2017 Goel, Archit. All rights reserved.
//

import Foundation

struct DemoURL {
    static let stanford = URL(string: "https://www-media.stanford.edu/wp-content/uploads/2017/03/24182714/about_landing-1.jpg")
    
    static var NASA: Dictionary<String, URL> = {
        let NASAURLSTRINGS = [
            "Cassini": "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth": "http://www.nasa.gov/sites/defualt/files/wave_earth_mosaic_3.jpg",
            "Saturn":"https://www.nasa.gov/sites/default/files/saturn_collage.jpg"]
        
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLSTRINGS {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
