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
    
    
    @IBOutlet weak var SchBr: UISearchBar!
    
    var repo: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var idx: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else { return }
        guard let searchWord = searchBar.text else { return }
        
        word = searchWord
        url = "https://api.github.com/search/repositories?q=\(searchWord)"
        
        guard let searchURLStr = url, let encodeURLStr = searchURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodeURLStr) else { return }
        

        task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                if let items = obj["items"] as? [[String: Any]] {
                self.repo = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.SchBr.resignFirstResponder()
        
        idx = indexPath.row
        
        let FetchDataShowVC = FetchedDataShowViewBuilder.create() as! FetchedDataShowViewController
        FetchDataShowVC.SerchGitHubRepVC = self
        self.navigationController?.pushViewController(FetchDataShowVC, animated: true)
    }
    
    func inject(with presenter: SearchGitHubRepositoriesViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension SearchGitHubRepositoriesViewController: SearchGitHubRepositoriesViewPresenterOutput {
    
}
