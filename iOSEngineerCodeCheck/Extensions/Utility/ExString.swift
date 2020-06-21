//
//  ExString.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation

extension String {
    func removeAt(text: String) -> String? {
        if let range = self.range(of: text) {
            return self.replacingCharacters(in: range, with: "")
        }
        return nil
    }
}
