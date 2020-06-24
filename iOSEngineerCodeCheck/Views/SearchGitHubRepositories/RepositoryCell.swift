//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/24.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupFullNameLabel()
        setupLanguageLabel()
    }
    
    func setupFullNameLabel() {
        self.fullNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupLanguageLabel() {
        self.languageLabel.adjustsFontSizeToFitWidth = true
    }
}
