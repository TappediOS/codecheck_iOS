//
//  SampleViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SampleViewController: UIViewController {
    private var presenter: SampleViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: SampleViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension SampleViewController: SampleViewPresenterOutput {
    
}
