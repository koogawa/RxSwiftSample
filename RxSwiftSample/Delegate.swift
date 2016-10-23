//
//  Delegate.swift
//  RxSwiftSample
//
//  Created by koogawa on 2016/05/15.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

public final class Delegate: NSObject, UITableViewDelegate {

    // MARK: - UITableView Delegate

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
