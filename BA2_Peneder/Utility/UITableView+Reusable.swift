//
//  UITableView+Reusable.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 22.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

/// Provides default implementations of generic reuse methods on UICollectionView to
/// allow for consumers to register reuseable views for reuse such as UICollectionViewCells.
internal extension UITableView {
    
    /// Registers a UICollectionViewCell subclass for reuse, by
    /// registering a UINib or Type for the object's reuseIdentifier.
    ///
    /// - Parameter _: UICollectionViewCell to register for reuse.
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// Dequeues a UICollectionViewCell for reuse given a specific indexPath.
    ///
    /// - Parameter indexPath: indexPath to dequeue cell for
    /// - Returns: a reused UICollectionViewCell associated with the indexPath
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T
    }
    
}
