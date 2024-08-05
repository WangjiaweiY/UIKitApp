//
//  ViewController.swift
//  RTCubeApp
//
//  Created by joewwwang on 2024/5/23.
//  Copyright © 2024 Tencent. All rights reserved.
//

import UIKit

class AINoiseReductionViewController: UIViewController{
    
    let viewModel: AINoiseReductionViewModel
    
    init() {
        viewModel = AINoiseReductionViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = AINoiseReductionRootView(viewModel: viewModel)
        self.view = view
    }
}
