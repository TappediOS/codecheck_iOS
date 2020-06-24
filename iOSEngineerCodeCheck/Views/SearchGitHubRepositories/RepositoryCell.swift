//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/24.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupFullNameLabel()
        setupLanguageLabel()
        setupLAuthorLabel()
    }
    
    func setupFullNameLabel() {
        self.repositoryName.adjustsFontSizeToFitWidth = true
    }
    
    func setupLanguageLabel() {
        self.languageLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupLAuthorLabel() {
        self.authorLabel.adjustsFontSizeToFitWidth = true
    }
}
