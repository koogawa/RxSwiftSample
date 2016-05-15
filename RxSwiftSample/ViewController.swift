//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Kosuke Ogawa on 2016/05/12.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import SwiftyJSON
import FoursquareAPIClient

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private

    func fetch() {
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
    }

    func parseVenues(venuesJSON: JSON) -> [Venue] {
        var venues = [Venue]()
        for (key: _, venueJSON: JSON) in venuesJSON {
            venues.append(Venue(json: JSON))
        }
        return venues
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

    // MARK: - UITableView Delegate

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
