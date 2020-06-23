//
//  Routes.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

struct Routes {
    static func decideRootViewController() -> UIViewController {
        return SearchGitHubRepositoriesViewBuilder.create()
    }
}
