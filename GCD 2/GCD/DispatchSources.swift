//
//  DispatchSources.swift
//  GCD
//
//  Created by Vuk Knežević on 7/22/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class DispatchSources: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue(label: "Izvori", attributes: .concurrent)
        
        let timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.init(rawValue: UInt(SIGEMT)), queue: queue)//makeTimerSource(signal: SIGEMT ,queue: queue)
        
        timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .microseconds(300))
        timer.setEventHandler {
            print("Hello Word")
        }
        
        timer.setCancelHandler {
            print("timer cancelled")
        }
        
        timer.resume()
    }
}
