//
//  SearchGitHubRepositoriesPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGitHubRepositoriesViewPresenterProtocol {
    var view: SearchGitHubRepositoriesViewPresenterOutput! { get set }
    
    func searchRepositories(searchUrlStr: String)
    func didChangeSearchBar()
}

protocol SearchGitHubRepositoriesViewPresenterOutput {
    func setRepositoriesInfomation(repositoriesInfo: [[String: Any]])
}

final class SearchGitHubRepositoriesViewPresenter: SearchGitHubRepositoriesViewPresenterProtocol, SearchGitHubRepositoriesModelOutput {
    var view: SearchGitHubRepositoriesViewPresenterOutput!
    private var model: SearchGitHubRepositoriesModelProtocol
    
    init(model: SearchGitHubRepositoriesModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func searchRepositories(searchUrlStr: String) {
        guard let encodeURLStr = searchUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let searchURL = URL(string: encodeURLStr) else { return }
        
        model.fetchRepositories(searchURL: searchURL)
    }
    
    func fetchedRepositoriesInfomation(repositoriesInfo: [[String: Any]]) {
        view.setRepositoriesInfomation(repositoriesInfo: repositoriesInfo)
    }
    
    func didChangeSearchBar() {
        model.cancelURLSesstionTask()
    }
}
