//
//  FavoriteRepositoriesBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

struct FavoriteRepositoriesViewBuilder {
    static func create() -> UIViewController {
        guard let FavoriteRepositoriesViewController = FavoriteRepositoriesViewController.loadFromStoryboard() as? FavoriteRepositoriesViewController else {
            fatalError("fatal: Failed to initialize the FavoriteRepositoriesViewController")
        }
        let model = FavoriteRepositoriesModel()
        let presenter = FavoriteRepositoriesViewPresenter(model: model)
        FavoriteRepositoriesViewController.inject(with: presenter)
        return FavoriteRepositoriesViewController
    }
}
