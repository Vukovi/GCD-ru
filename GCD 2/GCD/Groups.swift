//
//  Groups.swift
//  GCD
//
//  Created by Vuk Knežević on 7/22/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class Groups: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue(label: "concurrent", attributes: .concurrent)
        
        let group = DispatchGroup()
        
        queue.async(group: group) {
            for i in 0...10 {
                if i == 10 {
                    print(i)
                }
            }
        }
        
        
        queue.async(group: group) {
            for i in 0...20 {
                if i == 20 {
                    print(i)
                }
            }
        }
        
        group.notify(queue: .main) {
            print("Gotova grupa")
        }
        // 10
        // 20
        // Gotova grupa
        
        let groupTwo = DispatchGroup()
        groupTwo.enter()
        queue.async(group: group) {
            for i in 0...30 {
                if i == 30 {
                    print(i)
                    sleep(2)
                    groupTwo.leave()
                }
            }
        }
        
        let result = groupTwo.wait(timeout: .now() + 1)
        print(result)
        
        groupTwo.notify(queue: .main) {
            print("Gotova grupa 2")
        }
        // 10
        // 20
        // 30
        // timedout
        // Gotova grupa
        // Gotova grupa 2
        
        print("VIDI OVO")
        // 10
        // 20
        // 30
        // timedout
        // VIDI OVO
        // Gotova grupa
        // Gotova grupa 2
        
        groupTwo.wait() // zbog ovoga ce grupa dva cekati sve dok joj se ne kaze da na ceka vise
    }
}
