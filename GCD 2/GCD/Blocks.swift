//
//  Blocks.swift
//  GCD
//
//  Created by Vuk Knežević on 7/22/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class BlokoviPomocuWorkItema: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
            print("Performing work item")
        }
        
        workItem.perform()
        
        let queue = DispatchQueue(label: "concurrent", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))
        
        queue.asyncAfter(deadline: .now() + 1, execute: workItem)
        
        workItem.notify(queue: .main) {
            print("Work Item je gotova")
        }
        
        workItem.isCancelled // false
        workItem.cancel()
        workItem.isCancelled // true
        
        workItem.wait() // dalje se kod ne izvrsava
        
    }
}
