//
//  SearchGitHubRepositoriesModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

protocol SearchGitHubRepositoriesModelProtocol {
    var presenter: SearchGitHubRepositoriesModelOutput! { get set }
}

protocol SearchGitHubRepositoriesModelOutput {
    
}

final class SearchGitHubRepositoriesModel: SearchGitHubRepositoriesModelProtocol {
    var presenter: SearchGitHubRepositoriesModelOutput!
}
