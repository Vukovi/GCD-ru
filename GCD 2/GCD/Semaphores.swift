//
//  Semaphores.swift
//  GCD
//
//  Created by Vuk Knežević on 7/22/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class Semaphores: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue(label: "Semafor", attributes: .concurrent)
        
        let semaphore = DispatchSemaphore(value: 2) // 0
        // semaphore.signal()
        queue.async {
            semaphore.wait(timeout: .distantFuture) // cekaj beskonacno dugo dok ne dobijes signal
            Thread.sleep(forTimeInterval: 4)
            print("Blok 1")
            semaphore.signal()
        }
        
        queue.async {
            semaphore.wait(timeout: .distantFuture) // cekaj beskonacno dugo dok ne dobijes signal
            Thread.sleep(forTimeInterval: 2)
            print("Blok 2")
            semaphore.signal()
        }
        
        queue.async {
            semaphore.wait(timeout: .distantFuture) // cekaj beskonacno dugo dok ne dobijes signal
            print("Blok 3")
            semaphore.signal()
        }
        
        queue.async {
            semaphore.wait(timeout: .distantFuture) // cekaj beskonacno dugo dok ne dobijes signal
            print("Blok 4")
            semaphore.signal()
        }
        
        // Blok 2
        // Blok 3
        // Blok 4
        // Blok 1
        
        // da je semaphor 0 i da je dat sigan bilo bi:
        // Blok 1
        // Blok 2
        // Blok 3
        // Blok 4
    }
}
