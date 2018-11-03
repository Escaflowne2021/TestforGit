//
//  multicast.swift
//  TestforGit
//
//  Created by Cormier on 27/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import Foundation

class MulticastDelegate <T> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func add(delegate: T) {
        print("add \(delegate)")
        delegates.add(delegate as AnyObject)
    }
    
    func remove(delegate: T) {
        for oneDelegate in delegates.allObjects.reversed() {
            if oneDelegate === delegate as AnyObject {
                delegates.remove(oneDelegate)
            }
        }
    }
    
    func invoke(invocation: (T) -> ()) {
        print("invoke \(invocation)")
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
}

func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.add(delegate: right)
}

func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.remove(delegate: right)
}
