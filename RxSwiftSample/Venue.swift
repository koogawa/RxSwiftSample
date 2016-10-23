//
//  Venue.swift
//  VenueMap
//
//  Created by koogawa on 2015/07/21.
//  Copyright (c) 2015 Kosuke Ogawa. All rights reserved.
//

import UIKit
import SwiftyJSON

let kCategoryIconSize = 88  // pixel

public struct Venue: CustomStringConvertible {

    let venueId: String
    let name: String
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let categoryIconURL: URL?

    public var description: String {
        return "<venueId=\(venueId)"
            + ", name=\(name)"
            + ", address=\(address)"
            + ", latitude=\(latitude), longitude=\(longitude)"
            + ", categoryIconURL=\(categoryIconURL)>"
    }

    init(json: JSON) {
        self.venueId = json["id"].string ?? ""
        self.name = json["name"].string ?? ""
        self.address = json["location"]["address"].string
        self.latitude = json["location"]["lat"].double
        self.longitude = json["location"]["lng"].double

        // Primary Category
        if let categories = json["categories"].array, categories.count > 0 {
            let prefix = json["categories"][0]["icon"]["prefix"].string ?? ""
            let suffix = json["categories"][0]["icon"]["suffix"].string ?? ""
            let iconUrlString = String(format: "%@%d%@", prefix, kCategoryIconSize, suffix)
            self.categoryIconURL = URL(string: iconUrlString)
        }
        else {
            self.categoryIconURL = nil
        }
    }
}
