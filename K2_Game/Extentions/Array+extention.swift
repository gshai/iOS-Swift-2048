//
//  Array+extention.swift
//  K2_Game
//
//  Created by Gilad Shai on 6/22/14.
//  Copyright (c) 2014 Gilad Shai. All rights reserved.
//

import Foundation

extension Array {
    func contains<T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    func distinct<T : Equatable>(_: T) -> T[] {
        var rtn = T[]()
        
        for x in self {
            if !rtn.contains(x as T) {
                rtn += x as T
            }
        }
        
        return rtn
    }
}