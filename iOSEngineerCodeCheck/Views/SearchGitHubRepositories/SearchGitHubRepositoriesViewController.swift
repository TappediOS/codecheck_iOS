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
    
    var urlSesstionTask: URLSessionTask?
    var searchWord: String = ""
    var url: String = ""
    var tableViewTappedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gitHubRepositoriesSearchBar.text = "GitHubのリポジトリを検索できるよー"
        gitHubRepositoriesSearchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        urlSesstionTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        
        searchWord = searchBarText
        url = "https://api.github.com/search/repositories?q=\(searchWord)"
        
        guard let encodeURLStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let searchURL = URL(string: encodeURLStr) else { return }
        
        urlSesstionTask = URLSession.shared.dataTask(with: searchURL) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let RepositoriesInfomation = jsonObject["items"] as? [[String: Any]] else { return }
            
            self.searchedRepositoriesInfomation = RepositoriesInfomation
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        urlSesstionTask?.resume()
    }
    
    func inject(with presenter: SearchGitHubRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension SearchGitHubRepositoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedRepositoriesInfomation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let RepositoryInfo = searchedRepositoriesInfomation[indexPath.row]
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

extension SearchGitHubRepositoriesViewController: SearchGitHubRepositoriesViewPresenterOutput {
    
}
