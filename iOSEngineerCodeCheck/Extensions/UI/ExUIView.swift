//
//  ExUIView.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

public extension UIView {
    class func create<T>() -> T where T: UIView {
        let nib = UINib(nibName: NSStringFromClass(self).components(separatedBy: ".").last!, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
