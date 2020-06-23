//
//  FetchedDataShowViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class FetchedDataShowViewController: UIViewController {
    private var presenter: FetchedDataShowViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: FetchedDataShowViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FetchedDataShowViewController: FetchedDataShowViewPresenterOutput {
    
}
