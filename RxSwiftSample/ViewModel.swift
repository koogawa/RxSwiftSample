//
//  ViewModel.swift
//  RxSwiftSample
//
//  Created by koogawa on 2016/05/15.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import FoursquareAPIClient

public final class ViewModel {

    private(set) var venues = Variable<[Venue]>([])
    let disposeBag = DisposeBag()

    init() {
        // NOOP
    }

    // MARK: - Public

    public func fetch() {
        self.send()
            .subscribe { [weak self] (event) -> Void in
                switch event {
                case .Next(let value):
                    self?.venues.value = value
                case .Error(_):
                    ()
                case .Completed:
                    ()
                }
            }
            .addDisposableTo(disposeBag)
    }

    // MARK: - Private

    // TODO: ここもクラス化
    func send() -> Observable<[Venue]> {
        return Observable.create{ (observer) in
            let client = FoursquareAPIClient(accessToken: "YOUR_TOKEN")
            let parameter: [String: String] = [
                "ll": "40.7,-74",
            ];
            client.requestWithPath("venues/search", parameter: parameter) {
                [weak self] (data, error) in
                let json = JSON(data: data!)
                let venues = (self?.parseVenues(json["response"]["venues"])) ?? [Venue]()
                observer.on(.Next(venues))
                observer.on(.Completed)
            }
            return AnonymousDisposable {}
        }
    }

    func parseVenues(venuesJSON: JSON) -> [Venue] {
        var venues = [Venue]()
        for (key: _, venueJSON: JSON) in venuesJSON {
            venues.append(Venue(json: JSON))
        }
        return venues
    }
}
