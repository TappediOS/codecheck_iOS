//
//  FetchedDataShowBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

struct FetchedDataShowViewBuilder {
    static func create() -> UIViewController {
        guard let fetchedDataShowViewController = FetchedDataShowViewController.loadFromStoryboard() as? FetchedDataShowViewController else {
            fatalError("fatal: Failed to initialize the FetchedDataShowViewController")
        }
        let model = FetchedDataShowModel()
        let presenter = FetchedDataShowViewPresenter(model: model)
        fetchedDataShowViewController.inject(with: presenter)
        return fetchedDataShowViewController
    }
}
