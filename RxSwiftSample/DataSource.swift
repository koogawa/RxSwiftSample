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

    private var venues = [Venue]()

    // MARK: - RxTableView DataSourceType

    public func tableView(tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .Next(let value):
            self.venues = value
            tableView.reloadData()
        case .Error(_):
            ()
        case .Completed:
            ()
        }
    }

    // MARK: - UITableView DataSource

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }

    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VenueCell", forIndexPath: indexPath)
        cell.textLabel?.text = self.venues[indexPath.row].name
        cell.detailTextLabel?.text = self.venues[indexPath.row].address
        return cell
    }

}
