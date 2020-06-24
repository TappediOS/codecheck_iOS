//
//  SearchGitHubRepositoriesModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchGitHubRepositoriesModelProtocol {
    var presenter: SearchGitHubRepositoriesModelOutput! { get set }
    
    func fetchRepositories(searchURL: URL)
    func cancelURLSesstionTask()
}

protocol SearchGitHubRepositoriesModelOutput {
    func fetchedRepositoriesInfomation(repositoriesInfo: [[String: Any]])
}

final class SearchGitHubRepositoriesModel: SearchGitHubRepositoriesModelProtocol {
    var presenter: SearchGitHubRepositoriesModelOutput!
    var urlSesstionTask: URLSessionTask?
    
    func fetchRepositories(searchURL: URL) {
        urlSesstionTask = URLSession.shared.dataTask(with: searchURL) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let RepositoriesInfomation = jsonObject["items"] as? [[String: Any]] else { return }
            
            self.presenter.fetchedRepositoriesInfomation(repositoriesInfo: RepositoriesInfomation)
        }
        urlSesstionTask?.resume()
    }
    
    func cancelURLSesstionTask() {
        urlSesstionTask?.cancel()
    }
}
