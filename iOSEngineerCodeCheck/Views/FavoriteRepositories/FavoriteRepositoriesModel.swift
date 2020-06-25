//
//  FavoriteRepositoriesModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteRepositoriesModelProtocol {
    var presenter: FavoriteRepositoriesModelOutput! { get set }
    func getFavoriteRepositories() -> [[String: Any]]
}

protocol FavoriteRepositoriesModelOutput {
    
}

final class FavoriteRepositoriesModel: FavoriteRepositoriesModelProtocol {
    var presenter: FavoriteRepositoriesModelOutput!
    var realm = try! Realm()
    
    /// Realmからお気に入りリポジトリーを全て取り出す
    /// - Returns: お気に入りされた全てのリポジトリー
    func getFavoriteRepositories() -> [[String: Any]] {
        let favoriteRepositoriesObject = self.realm.objects(FavoriteRepository.self)
        var result: [[String: Any]] = []
        
        for favoliteRepo in favoriteRepositoriesObject {
            var repositoryInfo: [String: Any] = Dictionary()
            
            repositoryInfo.updateValue(favoliteRepo.language ?? "No language used", forKey: GitHubSearchResultString.language.rawValue)
            repositoryInfo.updateValue(favoliteRepo.stargazers_count, forKey: GitHubSearchResultString.stargazers_count.rawValue)
            repositoryInfo.updateValue(favoliteRepo.watchers_count, forKey: GitHubSearchResultString.watchers_count.rawValue)
            repositoryInfo.updateValue(favoliteRepo.forks_count, forKey: GitHubSearchResultString.forks_count.rawValue)
            repositoryInfo.updateValue(favoliteRepo.open_issues_count, forKey: GitHubSearchResultString.open_issues_count.rawValue)
            repositoryInfo.updateValue(favoliteRepo.full_name ?? "", forKey: GitHubSearchResultString.full_name.rawValue)
            repositoryInfo.updateValue(favoliteRepo.avatar_url ?? "", forKey: GitHubSearchResultString.avatar_url.rawValue)
            
            let imageNSData = favoliteRepo.profileImageData
            if let nsData = imageNSData {
                let imageData = nsData as Data
                repositoryInfo.updateValue(imageData, forKey: GitHubSearchResultString.profileImageData.rawValue)
            }

            result.append(repositoryInfo)
        }
        
        return result
    }
}
