//
//  SearchGitHubRepositoriesBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

struct SearchGitHubRepositoriesViewBuilder {
    static func create() -> UIViewController {
        guard let searchGitHubRepositoriesViewController = SearchGitHubRepositoriesViewController.loadFromStoryboard() as? SearchGitHubRepositoriesViewController else {
            fatalError("fatal: Failed to initialize the SearchGitHubRepositoriesViewController")
        }
        let model = SearchGitHubRepositoriesModel()
        let presenter = SearchGitHubRepositoriesViewPresenter(model: model)
        searchGitHubRepositoriesViewController.inject(with: presenter)
        return searchGitHubRepositoriesViewController
    }
}
