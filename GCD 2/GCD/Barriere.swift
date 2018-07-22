//
//  Barriere.swift
//  GCD
//
//  Created by Vuk Knežević on 7/22/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class BarriereClass: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var array = [Int]()
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            array.append(index)
        }
        print("array: \(array)")
        // 1. put printa
        // "array: [1, 4, 5, 6, 7, 8, 9, 10]"
        // 2. put printa
        // "array: [3, 4, 6, 7, 8, 9]"
        // ovo se dogadja zbog RACE CONDITION-a
        
        
        var safeArray = SafeArray<Int>()
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            safeArray.append(element: index)
        }
        print("safeArray: \(safeArray.elements)")
        // svaki put printa
        // "safeArray: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]"
    }
    
}

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "Barriere", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        // ovde mora sync obavezno zbog toga sto mora da se zavrse svi taskovi koji upisuju u property array, a kojima barijera ne dozvoljava da pocnu dok se ona ne zavrsi
        queue.sync {
            result = self.array
        }
        return result
    }
}
