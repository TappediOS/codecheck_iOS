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
    @objc dynamic var language: String?
    @objc dynamic var stargazers_count = 0
    @objc dynamic var watchers_count = 0
    @objc dynamic var forks_count = 0
    @objc dynamic var open_issues_count = 0
    @objc dynamic var full_name: String?
    @objc dynamic var avatar_url: String?
    @objc dynamic var profileImageData: NSData?
}
