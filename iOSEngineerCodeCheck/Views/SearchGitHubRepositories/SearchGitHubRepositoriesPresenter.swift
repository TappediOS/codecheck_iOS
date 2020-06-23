//
//  SearchGitHubRepositoriesPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

protocol SearchGitHubRepositoriesViewPresenterProtocol {
    var view: SearchGitHubRepositoriesViewPresenterOutput! { get set }
}

protocol SearchGitHubRepositoriesViewPresenterOutput {
    
}

final class SearchGitHubRepositoriesViewPresenter: SearchGitHubRepositoriesViewPresenterProtocol, SearchGitHubRepositoriesModelOutput {
    var view: SearchGitHubRepositoriesViewPresenterOutput!
    private var model: SearchGitHubRepositoriesModelProtocol
    
    init(model: SearchGitHubRepositoriesModelProtocol) {
        self.model = model
    }
}
