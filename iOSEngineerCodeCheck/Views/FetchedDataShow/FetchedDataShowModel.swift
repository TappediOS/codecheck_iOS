//
//  FetchedDataShowModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput! { get set }
    
    func fetchProfileImageData(searchURL: URL)
}

protocol FetchedDataShowModelOutput {
    func fetchedProfileImageData(fetchedImageData: Data)
}

final class FetchedDataShowModel: FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput!
    
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
    
}
