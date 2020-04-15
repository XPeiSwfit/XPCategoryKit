//
//  Optional+Extension.swift
//  Pods-XPCategoryKit_Tests
//
//  Created by admin on 2020/4/15.
//

import Foundation

extension Optional{
    /// 可选值为空返回 true
    var isNone:Bool{
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }

    /// 可选值不为空 返回true
    var isSome:Bool{
        return !isNone
    }
}
