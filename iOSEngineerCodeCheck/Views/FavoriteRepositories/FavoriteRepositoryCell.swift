//
//  FavoriteRepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class FavoriteRepositoryCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
           
        self.setupProfileImageView()
        self.setupRepositoryNameLabel()
        self.setupLanguageNameLabel()
    }
        
    func setupProfileImageView() {
        self.profileImageView.layer.cornerRadius = 5
        self.profileImageView.layer.masksToBounds = true
    }
    
    func setupRepositoryNameLabel() {
        self.repositoryNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupLanguageNameLabel() {
        self.languageNameLabel.adjustsFontSizeToFitWidth = true
    }
}
