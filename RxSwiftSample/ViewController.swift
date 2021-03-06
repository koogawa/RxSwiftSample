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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = ViewModel()
    var dataSource = DataSource()
    var delegate = Delegate()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self.delegate

        self.searchBar.rx.text.asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .drive(onNext: { query in
                print(query)
                self.viewModel.fetch(query: query)
            })
            .addDisposableTo(self.disposeBag)

        self.viewModel.venues
            .asDriver()
            .drive (
                self.tableView.rx.items(dataSource: self.dataSource)
            )
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx.itemSelected
            .bindNext { [weak self] indexPath in
                if let venue = self?.viewModel.venues.value[indexPath.row] {
                    let urlString = "https://foursquare.com/v/" + venue.venueId
                    if let url = URL(string: urlString) {
                        let safariViewController = SFSafariViewController(url: url)
                        self?.present(safariViewController, animated: true, completion: nil)
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
