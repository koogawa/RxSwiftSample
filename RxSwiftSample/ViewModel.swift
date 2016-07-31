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

    let client = VenuesAPIClient()
    let disposeBag = DisposeBag()

    init() {
        // NOOP
    }

    // MARK: - Public

    public func fetch(query: String = "") {
        client.search(query)
            .subscribe { [weak self] (event) -> Void in
                switch event {
                case .Next(let value):
                    self?.venues.value = value
                case .Error(let error):
                    print(error)
                case .Completed:
                    ()
                }
            }
            .addDisposableTo(disposeBag)
    }
}
