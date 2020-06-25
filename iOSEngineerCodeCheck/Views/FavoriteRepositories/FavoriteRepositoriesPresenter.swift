//
//  FavoriteRepositoriesPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol FavoriteRepositoriesViewPresenterProtocol {
    var view: FavoriteRepositoriesViewPresenterOutput! { get set }
    
    func requestFavoriteRepositories()
}

protocol FavoriteRepositoriesViewPresenterOutput {
    func setTableViewFavoliteRepositoriesInfo(RepoInfo: [[String: Any]])
}

final class FavoriteRepositoriesViewPresenter: FavoriteRepositoriesViewPresenterProtocol, FavoriteRepositoriesModelOutput {
    var view: FavoriteRepositoriesViewPresenterOutput!
    private var model: FavoriteRepositoriesModelProtocol
    
    init(model: FavoriteRepositoriesModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func requestFavoriteRepositories() {
        let repositoriesData = self.model.getFavoriteRepositories()
        self.view.setTableViewFavoliteRepositoriesInfo(RepoInfo: repositoriesData)
    }
}
