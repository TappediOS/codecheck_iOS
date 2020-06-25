//
//  FetchedDataShowPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol FetchedDataShowViewPresenterProtocol {
    var view: FetchedDataShowViewPresenterOutput! { get set }
    
    func searchProfileImage(imageURLStr: String)
    func checkIsFavoriteRepository(repositoryTitle: String)
    
    func requestAddFavoriteRepogitory(repositoryInfo: [String: Any])
    func requestRemoveFavoriteRepogitory(repositoryTitle: String)
}

protocol FetchedDataShowViewPresenterOutput {
    func setProfileImage(imageData: Data)
    func didAddFavoriteRepository()
    func didRemoveFavoriteRepository()
    func isFavoriteRepository(isFavorite: Bool)
    func errorHappenWhenAddOrRegisterFavorite()
}

final class FetchedDataShowViewPresenter: FetchedDataShowViewPresenterProtocol, FetchedDataShowModelOutput {
    var view: FetchedDataShowViewPresenterOutput!
    private var model: FetchedDataShowModelProtocol
    
    init(model: FetchedDataShowModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    /// プロフィールダウンロードしてってModelに伝える関数
    /// - Parameter imageURLStr: ダウンロード先のURL
    func searchProfileImage(imageURLStr: String) {
        guard let encodeImageURLStr = imageURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return}
        guard let url = URL(string: encodeImageURLStr) else { return }
        
        self.model.fetchProfileImageData(searchURL: url)
    }
    
    /// プロフィール画像ダウンロード終わったよってviewに伝える関数
    /// - Parameter fetchedImageData: ダウンロードした画像データ
    func fetchedProfileImageData(fetchedImageData: Data) {
        self.view.setProfileImage(imageData: fetchedImageData)
    }
    
    /// 引数のリポジトリーが既にお気に入り登録されているかを確認してってmodelに伝える関数
    /// - Parameter repositoryTitle: リポジトリー名
    func checkIsFavoriteRepository(repositoryTitle: String) {
        let isFavorite = model.isFavoriteRepository(repositoryTitle: repositoryTitle)
        self.view.isFavoriteRepository(isFavorite: isFavorite)
    }
    
    func requestAddFavoriteRepogitory(repositoryInfo: [String: Any]) {
        self.model.addFavoriteRepogitory(repositoryInfo: repositoryInfo)
    }
    
    func requestRemoveFavoriteRepogitory(repositoryTitle: String) {
        self.model.removeFavoriteRepogitory(repositoryTitle: repositoryTitle)
    }
    
    func didAddFavorite() {
        self.view.didAddFavoriteRepository()
    }
    
    func didRemoveFavorite() {
        self.view.didRemoveFavoriteRepository()
    }
    
    func errorHappenWhenAddOrRegisterFavorite() {
        self.view.errorHappenWhenAddOrRegisterFavorite()
    }
}

