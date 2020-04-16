//
//  Sequence+Extension.swift
//  Pods-XPCategoryKit_Tests
//
//  Created by admin on 2020/4/16.
//

import Foundation

extension Sequence{
    
    /// 根据闭包中的条件进行数据分组
    ///
    /// let data = ["a1","a2","c3","c4","a5","e6","e7","e8","a9","a10","c11","d12"]
    /// let result = data.groupBy(closure: { (s) in
    ///       s.prefix(1)
    /// })
    /// print(result)  -> ["a": ["a1", "a2", "a5", "a9", "a10"], "e": ["e6", "e7", "e8"], "c": ["c3", "c4", "c11"], "d": ["d12"]]
    ///
    ///成员分组
    func groupBy<G: Hashable>(closure: (Iterator.Element)->G) -> [G: [Iterator.Element]] {
        var results = [G: Array<Iterator.Element>]()
        
        forEach {
            let key = closure($0)
            
            if var array = results[key] {
                array.append($0)
                results[key] = array
            }
            else {
                results[key] = [$0]
            }
        }
        
        return results
    }
    
    
}
