//
//  FavoriteRepositoriesModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol FavoriteRepositoriesModelProtocol {
    var presenter: FavoriteRepositoriesModelOutput! { get set }
}

protocol FavoriteRepositoriesModelOutput {
    
}

final class FavoriteRepositoriesModel: FavoriteRepositoriesModelProtocol {
    var presenter: FavoriteRepositoriesModelOutput!
}
