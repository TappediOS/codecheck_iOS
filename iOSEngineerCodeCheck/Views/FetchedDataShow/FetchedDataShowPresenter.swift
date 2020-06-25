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
}

protocol FetchedDataShowViewPresenterOutput {
    func setProfileImage(imageData: Data)
    func didAddFavoriteRepository()
    func didRemoveFavoriteRepository()
    func isFavoriteRepository(isFavorite: Bool)
}

final class FetchedDataShowViewPresenter: FetchedDataShowViewPresenterProtocol, FetchedDataShowModelOutput {
    var view: FetchedDataShowViewPresenterOutput!
    private var model: FetchedDataShowModelProtocol
    
    init(model: FetchedDataShowModelProtocol) {
        self.model = model
        self.model.presenter = self
    }
    
    func searchProfileImage(imageURLStr: String) {
        guard let encodeImageURLStr = imageURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return}
        guard let url = URL(string: encodeImageURLStr) else { return }
        
        self.model.fetchProfileImageData(searchURL: url)
    }
    
    func fetchedProfileImageData(fetchedImageData: Data) {
        self.view.setProfileImage(imageData: fetchedImageData)
    }
    
    func checkIsFavoriteRepository(repositoryTitle: String) {
        let isFavorite = model.isFavoriteRepository(repositoryTitle: repositoryTitle)
        self.view.isFavoriteRepository(isFavorite: isFavorite)
    }
}

