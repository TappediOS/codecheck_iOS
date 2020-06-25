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
    
    var addFFavoriteRepositoryUIBarButtonItem = UIBarButtonItem()
    var removeFavoriteRepositoryUIBarButtonItem = UIBarButtonItem()
    
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupRepositoryInfomationLabels()
        self.setupUserProfileImageView()
        self.setupUIBarButtonItem()
        self.fetchUserProfileImage()
        self.requestCheckFavoriteRepository()
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
    
    func setupUIBarButtonItem() {
        self.removeFavoriteRepositoryUIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                                                       style: .plain, target: self, action: #selector(removeFavoriteRepository(_:)))
        self.addFFavoriteRepositoryUIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                                       style: .plain, target: self, action: #selector(addFavoriteRepository(_:)))
    }
    
    @objc func addFavoriteRepository(_ sender: UIButton) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.presenter.requestAddFavoriteRepogitory(repositoryInfo: self.searchedRepositoryInfomation)
    }
    
    @objc func removeFavoriteRepository(_ sender: UIButton) {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let repositoryTitle = self.searchedRepositoryInfomation[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        self.presenter.requestRemoveFavoriteRepogitory(repositoryTitle: repositoryTitle)
    }

    func fetchUserProfileImage(){
        if let profileImage = self.profileImage {
            self.userProfileImageView.image = profileImage
            return
        }
        
        guard let owner = self.searchedRepositoryInfomation[GitHubSearchResultString.owner.rawValue] as? [String: Any] else { return }
        guard let imageURLStr = owner[GitHubSearchResultString.avatar_url.rawValue] as? String else { return }
        
        self.presenter.searchProfileImage(imageURLStr: imageURLStr)
    }
    
    func requestCheckFavoriteRepository() {
        let repositoryTitle = self.searchedRepositoryInfomation[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        self.presenter.checkIsFavoriteRepository(repositoryTitle: repositoryTitle)
    }
    
    func inject(with presenter: FetchedDataShowViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FetchedDataShowViewController: FetchedDataShowViewPresenterOutput {
    func setProfileImage(imageData: Data) {
        self.searchedRepositoryInfomation.updateValue(imageData, forKey: GitHubSearchResultString.profileImageData.rawValue)
        guard let userImage = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.userProfileImageView.image = userImage
            self.userProfileImageView.alpha = 0
            UIView.animate(withDuration: 0.25, animations: {
                self.userProfileImageView.alpha = 1
            })
        }
    }
    
    func didAddFavoriteRepository() {
        self.navigationItem.rightBarButtonItem = self.removeFavoriteRepositoryUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func didRemoveFavoriteRepository() {
        self.navigationItem.rightBarButtonItem = self.addFFavoriteRepositoryUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func isFavoriteRepository(isFavorite: Bool) {
        if isFavorite {
            self.navigationItem.rightBarButtonItem = self.removeFavoriteRepositoryUIBarButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = self.addFFavoriteRepositoryUIBarButtonItem
        }
    }
    
    func errorHappenWhenAddOrRegisterFavorite() {
        
    }
}
