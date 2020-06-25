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
    
    func getFavoriteRepositories() -> [[String: Any]] {
        let favoriteRepositoriesObject = self.realm.objects(FavoriteRepository.self)
        var result: [[String: Any]] = []
        
        for favoliteRepo in favoriteRepositoriesObject {
            var repositoryInfo: [String: Any] = Dictionary()
            repositoryInfo.updateValue(favoliteRepo.repositoryName, forKey: GitHubSearchResultString.full_name.rawValue)
            repositoryInfo.updateValue(favoliteRepo.repositoryLanguage ?? "No language userd", forKey: GitHubSearchResultString.language.rawValue)
            repositoryInfo.updateValue(favoliteRepo.repositoryProfileImageData, forKey: GitHubSearchResultString.profileImageData.rawValue)
            result.append(repositoryInfo)
        }
        
        return result
    }
}
