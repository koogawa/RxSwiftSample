//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Kosuke Ogawa on 2016/05/12.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewModel()
    var dataSource = DataSource()
    var delegate = Delegate()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self.delegate
        self.viewModel.fetch()
        self.viewModel.venues
            .asDriver()
            .drive (
                self.tableView.rx_itemsWithDataSource(self.dataSource)
            )
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_itemSelected
            .bindNext { [weak self] (indexPath) -> Void in
                if let venue = self?.viewModel.venues.value[indexPath.row] {
                    let urlString = "https://foursquare.com/v/" + venue.venueId
                    if let url = NSURL(string: urlString) {
                        let safariViewController = SFSafariViewController(URL: url)
                        self?.presentViewController(
                            safariViewController,
                            animated: true,
                            completion: nil
                        )
                    }
                }
            }
            .addDisposableTo(self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
