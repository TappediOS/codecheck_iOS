//
//  ExUIViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

public extension UIViewController {
    class func loadFromStoryboard<T>() -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: NSStringFromClass(self).components(separatedBy: ".").last!.removeAt(text: "ViewController")!, bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}
