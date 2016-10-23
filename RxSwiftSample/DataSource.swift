//
//  DataSource.swift
//  RxSwiftSample
//
//  Created by koogawa on 2016/05/15.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public final class DataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {

    // MARK: - Alias

    public typealias Element = [Venue]

    // MARK: - Property

    fileprivate var venues = [Venue]()

    // MARK: - RxTableView DataSourceType

    public func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .next(let value):
            self.venues = value
            tableView.reloadData()
        case .error(_):
            ()
        case .completed:
            ()
        }
    }

    // MARK: - UITableView DataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath)
        cell.textLabel?.text = self.venues[(indexPath as NSIndexPath).row].name
        cell.detailTextLabel?.text = self.venues[(indexPath as NSIndexPath).row].address
        return cell
    }

}
