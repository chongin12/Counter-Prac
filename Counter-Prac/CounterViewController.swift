//
//  CounterViewController.swift
//  Counter-Prac
//
//  Created by 정종인 on 2020/06/07.
//  Copyright © 2020 swmaestro10th. All rights reserved.
//

import Foundation
import UIKit

class CounterViewController: UIViewController {
    private lazy var counterView = CounterView(controlBy: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterView.setup()
        counterView.reactor = CounterViewReactor()
    }
    
    override func loadView() {
        self.view = counterView
    }
}
