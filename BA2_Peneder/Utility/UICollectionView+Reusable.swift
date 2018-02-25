//
//  UICollectionView+Reusable.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 21.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

/// Provides default implementations of generic reuse methods on UICollectionView to
/// allow for consumers to register reuseable views for reuse such as UICollectionViewCells.
internal extension UICollectionView {
    
    /// Registers a UICollectionViewCell subclass for reuse, by
    /// registering a UINib or Type for the object's reuseIdentifier.
    ///
    /// - Parameter _: UICollectionViewCell to register for reuse.
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_ : T.Type, kind: String) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// Dequeues a UICollectionViewCell for reuse given a specific indexPath.
    ///
    /// - Parameter indexPath: indexPath to dequeue cell for
    /// - Returns: a reused UICollectionViewCell associated with the indexPath
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    
}


