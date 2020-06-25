//
//  FavoriteRepositoryObject.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteRepository: Object {
    @objc dynamic var repositoryName = ""
    @objc dynamic var repositoryLanguage: String?
    @objc dynamic var repositoryProfileImageData = Data()
}
