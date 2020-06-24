//
//  SearchGitHubRepositoriesViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchGitHubRepositoriesViewController: UITableViewController, UISearchBarDelegate {
    private var presenter: SearchGitHubRepositoriesViewPresenterProtocol!
    
    @IBOutlet weak var gitHubRepositoriesSearchBar: UISearchBar!
    
    var searchedRepositoriesInfomation: [[String: Any]]=[]
    
    var searchWord: String = ""
    var url: String = ""
    var tableViewTappedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gitHubRepositoriesSearchBar.text = "GitHubのリポジトリを検索できるよー"
        self.gitHubRepositoriesSearchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.didChangeSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        
        self.searchWord = searchBarText
        self.url = "https://api.github.com/search/repositories?q=\(searchWord)"
        self.presenter.searchRepositories(searchUrlStr: self.url)
    }
    
    func inject(with presenter: SearchGitHubRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension SearchGitHubRepositoriesViewController: SearchGitHubRepositoriesViewPresenterOutput {
    func setRepositoriesInfomation(repositoriesInfo: [[String: Any]]) {
        self.searchedRepositoriesInfomation = repositoriesInfo
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}

extension SearchGitHubRepositoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedRepositoriesInfomation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let RepositoryInfo = self.searchedRepositoriesInfomation[indexPath.row]
        cell.textLabel?.text = RepositoryInfo[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        cell.detailTextLabel?.text = RepositoryInfo[GitHubSearchResultString.language.rawValue] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gitHubRepositoriesSearchBar.resignFirstResponder()
        
        tableViewTappedCellIndex = indexPath.row
        let FetchDataShowVC = FetchedDataShowViewBuilder.create() as! FetchedDataShowViewController
        FetchDataShowVC.SerchGitHubRepVC = self
        self.navigationController?.pushViewController(FetchDataShowVC, animated: true)
    }
}
