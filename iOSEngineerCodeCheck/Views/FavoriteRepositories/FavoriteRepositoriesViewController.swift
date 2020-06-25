//
//  FavoriteRepositoriesViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class FavoriteRepositoriesViewController: UIViewController {
    private var presenter: FavoriteRepositoriesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(with presenter: FavoriteRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FavoriteRepositoriesViewController: FavoriteRepositoriesViewPresenterOutput {
    
}
