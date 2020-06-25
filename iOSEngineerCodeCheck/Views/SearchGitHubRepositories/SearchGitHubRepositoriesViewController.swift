//
//  SearchGitHubRepositoriesViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

final class SearchGitHubRepositoriesViewController: UITableViewController, UISearchBarDelegate {
    private var presenter: SearchGitHubRepositoriesViewPresenterProtocol!
    
    @IBOutlet weak var gitHubRepositoriesSearchBar: UISearchBar!
    
    var searchedRepositoriesInfomation: [[String: Any]] = []
    
    var searchWord: String = ""
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        setupSearchBar()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 75
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Search"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchBar() {
        self.gitHubRepositoriesSearchBar.placeholder = "Repository"
        self.gitHubRepositoriesSearchBar.delegate = self
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.didChangeSearchBar()
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard self.gitHubRepositoriesSearchBar.isFirstResponder else { return }
        self.gitHubRepositoriesSearchBar.resignFirstResponder()
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else { return UITableViewCell() }
        
        let repositoryInfo = self.searchedRepositoriesInfomation[indexPath.row]
        let fullName = repositoryInfo[GitHubSearchResultString.full_name.rawValue] as? String ?? ""
        let repoName = fullName.components(separatedBy: "/").last ?? ""
        let authorName = fullName.components(separatedBy: "/").first ?? ""
        let language = repositoryInfo[GitHubSearchResultString.language.rawValue] as? String ?? "No language userd"
         
        cell.repositoryName.text = repoName
        cell.authorLabel.text = authorName
        cell.languageLabel.text = language
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gitHubRepositoriesSearchBar.resignFirstResponder()
        
        let FetchDataShowVC = FetchedDataShowViewBuilder.create() as! FetchedDataShowViewController
        FetchDataShowVC.searchedRepositoryInfomation = self.searchedRepositoriesInfomation[indexPath.row]
        self.navigationController?.pushViewController(FetchDataShowVC, animated: true)
    }
}

extension SearchGitHubRepositoriesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No results"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
   
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "It will be displayed when you search and find it."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
