//
//  FetchedDataShowViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class FetchedDataShowViewController: UIViewController {
    private var presenter: FetchedDataShowViewPresenterProtocol!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var repositoryTitleLabel: UILabel!
    
    @IBOutlet weak var repositoryLanguageLabel: UILabel!
    @IBOutlet weak var repositoryStarCountLabel: UILabel!
    @IBOutlet weak var repositoryWatchCountLabel: UILabel!
    @IBOutlet weak var repositoryForkCountLabel: UILabel!
    @IBOutlet weak var repositoryOpenIssuesCountLabel: UILabel!
        
    var searchedRepositoryInfomation: [String: Any] = Dictionary()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupRepositoryInfomationLabels()
        self.setupUserProfileImageView()
        self.fetchUserProfileImage()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Result"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupRepositoryInfomationLabels() {
        let language: String? = self.searchedRepositoryInfomation[GitHubSearchResultString.language.rawValue] as? String
        let starCount = self.searchedRepositoryInfomation[GitHubSearchResultString.stargazers_count.rawValue] as? Int ?? 0
        let watchCount = self.searchedRepositoryInfomation[GitHubSearchResultString.watchers_count.rawValue] as? Int ?? 0
        let forksCount = self.searchedRepositoryInfomation[GitHubSearchResultString.forks_count.rawValue] as? Int ?? 0
        let openIssuesCount = self.searchedRepositoryInfomation[GitHubSearchResultString.open_issues_count.rawValue] as? Int ?? 0
        let repositoryTitle = self.searchedRepositoryInfomation[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        
        //languageはnilの可能性があるので表示を変える必要がある
        if let language = language {
            self.repositoryLanguageLabel.text = "Written in \(language)"
        } else {
            self.repositoryLanguageLabel.text = "No language used"
        }
        self.repositoryStarCountLabel.text = "\(starCount) stars"
        self.repositoryWatchCountLabel.text = "\(watchCount) watchers"
        self.repositoryForkCountLabel.text = "\(forksCount) forks"
        self.repositoryOpenIssuesCountLabel.text = "\(openIssuesCount) open issues"
        self.repositoryTitleLabel.text = repositoryTitle
        self.repositoryTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupUserProfileImageView() {
        self.userProfileImageView.layer.cornerRadius = 8
        self.userProfileImageView.layer.masksToBounds = true
    }

    func fetchUserProfileImage(){
        guard let owner = self.searchedRepositoryInfomation[GitHubSearchResultString.owner.rawValue] as? [String: Any] else { return }
        guard let imageURLStr = owner[GitHubSearchResultString.avatar_url.rawValue] as? String else { return }
        
        self.presenter.searchProfileImage(imageURLStr: imageURLStr)
    }
    
    func inject(with presenter: FetchedDataShowViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FetchedDataShowViewController: FetchedDataShowViewPresenterOutput {
    func setProfileImage(imageData: Data) {
        guard let userImage = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.userProfileImageView.image = userImage
        }
    }
}
