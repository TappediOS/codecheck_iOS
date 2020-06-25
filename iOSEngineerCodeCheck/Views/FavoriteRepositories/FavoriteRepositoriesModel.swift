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
            repositoryInfo.updateValue(favoliteRepo.full_name ?? "", forKey: GitHubSearchResultString.full_name.rawValue)
            repositoryInfo.updateValue(favoliteRepo.language ?? "No language userd", forKey: GitHubSearchResultString.language.rawValue)
            repositoryInfo.updateValue(favoliteRepo.profileImageData ?? NSData(), forKey: GitHubSearchResultString.profileImageData.rawValue)
            result.append(repositoryInfo)
        }
        
        return result
    }
}
