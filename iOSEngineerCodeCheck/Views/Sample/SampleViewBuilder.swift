//
//  SampleViewBuilder.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

struct SampleViewBuilder {
    static func create() -> UIViewController {
        guard let sampleViewController = SampleViewController.loadFromStoryboard() as? SampleViewController else {
            fatalError("fatal: Failed to initialize the SampleViewController")
        }
        let model = SampleModel()
        let presenter = SampleViewPresenter(model: model)
        sampleViewController.inject(with: presenter)
        return sampleViewController
    }
}
