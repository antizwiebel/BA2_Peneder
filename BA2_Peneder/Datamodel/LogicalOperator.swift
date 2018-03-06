//
//  LogicalOperator.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 25.02.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation

/**
 A operator that links two rules with either a logical AND or OR.
 - OR:  a disjunction between rules.
 - AND: a conjunction between rules.
 */
public enum LogicalOperator {
    case AND
    case OR
}
