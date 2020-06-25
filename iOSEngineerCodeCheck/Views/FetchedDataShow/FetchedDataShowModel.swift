//
//  FetchedDataShowModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import RealmSwift

protocol FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput! { get set }
    
    func fetchProfileImageData(searchURL: URL)
    func isFavoriteRepository(repositoryTitle: String) -> Bool
    
    func addFavoriteRepogitory(repositoryInfo: [String: Any])
    func removeFavoriteRepogitory(repositoryTitle: String)
}

protocol FetchedDataShowModelOutput {
    func fetchedProfileImageData(fetchedImageData: Data)
    
    func didAddFavorite()
    func didRemoveFavorite()
    func errorHappenWhenAddOrRegisterFavorite()
}

final class FetchedDataShowModel: FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput!
    var realm = try! Realm()
    
    /// プロフィール画像のデータを取得する関数
    /// - Parameter searchURL: プロフィール画像がある保存先のURL
    func fetchProfileImageData(searchURL: URL) {
        URLSession.shared.dataTask(with: searchURL) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            guard let data = data else { return }
            
            self.presenter.fetchedProfileImageData(fetchedImageData: data)
        }.resume()
    }
    
    /// あるリポジトリーがRealmに登録されているかを返す関数
    /// - Parameter repositoryTitle: リポジトリー名
    /// - Returns: 保存されてるかどうか
    func isFavoriteRepository(repositoryTitle: String) -> Bool {
        let favoriteRepositoriesObject = self.realm.objects(FavoriteRepository.self)
        
        for favoliteRepo in favoriteRepositoriesObject {
            if favoliteRepo.full_name == repositoryTitle { return true }
        }
        
        return false
    }
    
    /// Realmにお気に入りリポジトリーを追加する
    /// - Parameter repositoryInfo: 追加するリポジトリー情報
    func addFavoriteRepogitory(repositoryInfo: [String: Any]) {
        let repositoryObjct = FavoriteRepository()
        
        let language = repositoryInfo[GitHubSearchResultString.language.rawValue] as? String ?? ""
        let stargazers_count = repositoryInfo[GitHubSearchResultString.stargazers_count.rawValue] as? Int ?? 0
        let watchers_count = repositoryInfo[GitHubSearchResultString.watchers_count.rawValue] as? Int ?? 0
        let forks_count = repositoryInfo[GitHubSearchResultString.forks_count.rawValue] as? Int ?? 0
        let open_issues_count = repositoryInfo[GitHubSearchResultString.open_issues_count.rawValue] as? Int ?? 0
        let full_name = repositoryInfo[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        let owner = repositoryInfo[GitHubSearchResultString.owner.rawValue] as? [String: Any] ?? [:]
        let avatar_url = owner[GitHubSearchResultString.avatar_url.rawValue] as? String ?? ""
        let profileImageData = repositoryInfo[GitHubSearchResultString.profileImageData.rawValue] as? Data
        var profileImageNSData: NSData?
        
        if let imageData = profileImageData {
            profileImageNSData = NSData.init(data: imageData)
        }
        
        repositoryObjct.language = language
        repositoryObjct.stargazers_count = stargazers_count
        repositoryObjct.watchers_count = watchers_count
        repositoryObjct.forks_count = forks_count
        repositoryObjct.open_issues_count = open_issues_count
        repositoryObjct.full_name = full_name
        repositoryObjct.avatar_url = avatar_url
        repositoryObjct.profileImageData = profileImageNSData
        
        do {
            try realm.write {
                realm.add(repositoryObjct)
            }
            self.presenter.didAddFavorite()
        } catch {
            self.presenter.errorHappenWhenAddOrRegisterFavorite()
        }
    }
    
    /// Realmからあるリポジトリーを削除する関数
    /// - Parameter repositoryTitle: 削除したいリポジトリー名
    func removeFavoriteRepogitory(repositoryTitle: String) {
        let favoriteRepositoriesObject = self.realm.objects(FavoriteRepository.self)
        
        for tmp in 0 ..< favoriteRepositoriesObject.count {
            if favoriteRepositoriesObject[tmp].full_name != repositoryTitle { continue }
               
            do {
                try realm.write {
                    realm.delete(favoriteRepositoriesObject[tmp])
                }
                self.presenter.didRemoveFavorite()
                return
            } catch {
                self.presenter.errorHappenWhenAddOrRegisterFavorite()
                return
            }
        }
        self.presenter.errorHappenWhenAddOrRegisterFavorite()
    }
}
