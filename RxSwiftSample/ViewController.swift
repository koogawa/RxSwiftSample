//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Kosuke Ogawa on 2016/05/12.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.rx_text
            .map {"「\($0)」"}
        .bindTo(label.rx_text)
        .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

