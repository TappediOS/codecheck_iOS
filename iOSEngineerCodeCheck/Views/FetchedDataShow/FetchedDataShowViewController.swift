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
    
    var SerchGitHubRepVC: SearchGitHubRepositoriesViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repositoryInfo = SerchGitHubRepVC.searchedRepositoriesInfomation[SerchGitHubRepVC.tableViewTappedCellIndex ?? 0]
        let language = repositoryInfo[GitHubSearchResultString.language.rawValue] as? String ?? ""
        let starCount = repositoryInfo[GitHubSearchResultString.stargazers_count.rawValue] as? String ?? ""
        let watchCount = repositoryInfo[GitHubSearchResultString.wachers_count.rawValue] as? Int ?? 0
        let forksCount = repositoryInfo[GitHubSearchResultString.forks_count.rawValue] as? Int ?? 0
        let openIssuesCount = repositoryInfo[GitHubSearchResultString.open_issues_count.rawValue] as? Int ?? 0
        
        repositoryLanguageLabel.text = "Written in \(language)"
        repositoryStarCountLabel.text = "\(starCount) stars"
        repositoryWatchCountLabel.text = "\(watchCount) watchers"
        repositoryForkCountLabel.text = "\(forksCount) forks"
        repositoryOpenIssuesCountLabel.text = "\(openIssuesCount) open issues"
        
        fetchUserProfileImage()
    }

    func fetchUserProfileImage(){
        let repo = SerchGitHubRepVC.searchedRepositoriesInfomation[SerchGitHubRepVC.tableViewTappedCellIndex ?? 0]
        
        repositoryTitleLabel.text = repo[GitHubSearchResultString.full_name.rawValue] as? String
        
        guard let owner = repo[GitHubSearchResultString.owner.rawValue] as? [String: Any] else { return }
        guard let imageURLStr = owner[GitHubSearchResultString.avatar_url.rawValue] as? String else { return }
        guard let encodeImageURLStr = imageURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return}
        guard let url = URL(string: encodeImageURLStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            guard let data = data else { return }
            guard let userImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.userProfileImageView.image = userImage
            }
        }.resume()
        
    }
    
    func inject(with presenter: FetchedDataShowViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FetchedDataShowViewController: FetchedDataShowViewPresenterOutput {
    
}
