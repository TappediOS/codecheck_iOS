//
//  FavoriteRepositoriesViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class FavoriteRepositoriesViewController: UIViewController {
    private var presenter: FavoriteRepositoriesViewPresenterProtocol!
    
    @IBOutlet weak var favoriteRepositoriesTableView: UITableView!
    
    var favoliteRepositoriesInfomation: [[String: Any]] = []
    var refleshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        
        requestFavoriteRepositories()
    }
    
    func setupTableView() {
        self.favoriteRepositoriesTableView.rowHeight = 75
        self.favoriteRepositoriesTableView.delegate = self
        self.favoriteRepositoriesTableView.dataSource = self
        self.favoriteRepositoriesTableView.refreshControl = self.refleshControl
        self.refleshControl.addTarget(self, action: #selector(self.reloadFavoriteRepositories(sender:)), for: .valueChanged)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Favorites"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func reloadFavoriteRepositories(sender: UIRefreshControl) {
        requestFavoriteRepositories()
    }
    
    func requestFavoriteRepositories() {
        self.presenter.requestFavoriteRepositories()
    }
    
    func inject(with presenter: FavoriteRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FavoriteRepositoriesViewController: FavoriteRepositoriesViewPresenterOutput {
    func setTableViewFavoliteRepositoriesInfo(RepoInfo: [[String: Any]]) {
        self.favoliteRepositoriesInfomation = RepoInfo
        DispatchQueue.main.async { self.favoriteRepositoriesTableView.reloadData() }
        
        if self.refleshControl.isRefreshing {
            DispatchQueue.main.async{ self.refleshControl.endRefreshing() }
        }
    }
}


extension FavoriteRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoliteRepositoriesInfomation.count
    }
    
    //Cellを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.favoriteRepositoriesTableView.dequeueReusableCell(withIdentifier: "FavoriteRepositoryCell", for: indexPath) as? FavoriteRepositoryCell else { return UITableViewCell() }
        
        let repositoryInfo = self.favoliteRepositoriesInfomation[indexPath.row]
        let fullName = repositoryInfo[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        let language = repositoryInfo[GitHubSearchResultString.language.rawValue] as? String ?? "No language userd"
        let profileImageData = repositoryInfo[GitHubSearchResultString.profileImageData.rawValue] as? Data
        
        if let data = profileImageData, let image = UIImage(data: data) {
            cell.profileImageView.image = image
        }
        
        cell.repositoryNameLabel.text = fullName
        cell.languageNameLabel.text = language
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let FetchDataShowVC = FetchedDataShowViewBuilder.create() as! FetchedDataShowViewController
        FetchDataShowVC.searchedRepositoryInfomation = self.favoliteRepositoriesInfomation[indexPath.row]
        
        let profileImageData = self.favoliteRepositoriesInfomation[indexPath.row][GitHubSearchResultString.profileImageData.rawValue] as? Data
        if let data = profileImageData, let image = UIImage(data: data) {
            FetchDataShowVC.profileImage = image
        }
        self.navigationController?.pushViewController(FetchDataShowVC, animated: true)
    }
}
