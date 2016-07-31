//
//  VenuesAPIClient.swift
//  RxSwiftSample
//
//  Created by koogawa on 2016/07/30.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import FoursquareAPIClient

class VenuesAPIClient {

    func search(query: String = "") -> Observable<[Venue]> {
        return Observable.create{ (observer) in
            let client = FoursquareAPIClient(accessToken: "YOUR_TOKEN")
            let parameter: [String: String] = [
                "ll": "40.7,-74",
                "query": query
            ];
            client.requestWithPath("venues/search", parameter: parameter) {
                [weak self] (data, error) in
                guard let strongSelf = self, data = data else { return }
                let json = JSON(data: data)
                let venues = strongSelf.parseVenues(json["response"]["venues"])
                observer.on(.Next(venues))
                observer.on(.Completed)
            }
            return AnonymousDisposable {}
        }
    }

    private func parseVenues(venuesJSON: JSON) -> [Venue] {
        var venues = [Venue]()
        for (key: _, venueJSON: JSON) in venuesJSON {
            venues.append(Venue(json: JSON))
        }
        return venues
    }
}
