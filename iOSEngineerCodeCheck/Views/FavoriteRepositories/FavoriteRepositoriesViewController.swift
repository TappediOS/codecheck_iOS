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
    
    @IBOutlet weak var favoriteRepositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
    }
    
    func setupTableView() {
        self.favoriteRepositoriesTableView.rowHeight = 75
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Favorites"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func inject(with presenter: FavoriteRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FavoriteRepositoriesViewController: FavoriteRepositoriesViewPresenterOutput {
    
}
