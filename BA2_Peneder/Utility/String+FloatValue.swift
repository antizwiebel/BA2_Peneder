//
//  String+FloatValue.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 09.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

extension String {
    public var floatValue: Float {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.floatValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.floatValue
            }
        }
        return 0
    }
}
