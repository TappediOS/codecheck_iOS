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
    
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var SerchGitHubRepVC: SearchGitHubRepositoriesViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = SerchGitHubRepVC.repo[SerchGitHubRepVC.idx ?? 0]
        
        LangLbl.text = "Written in \(repo[GitHubSearchResultString.language.rawValue] as? String ?? "")"
        StrsLbl.text = "\(repo[GitHubSearchResultString.stargazers_count.rawValue] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo[GitHubSearchResultString.wachers_count.rawValue] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo[GitHubSearchResultString.forks_count.rawValue] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo[GitHubSearchResultString.open_issues_count.rawValue] as? Int ?? 0) open issues"
        getImage()
    }
    
    func getImage(){
        
        let repo = SerchGitHubRepVC.repo[SerchGitHubRepVC.idx ?? 0]
        
        TtlLbl.text = repo[GitHubSearchResultString.full_name.rawValue] as? String
        
        if let owner = repo[GitHubSearchResultString.owner.rawValue] as? [String: Any] {
            if let imgURL = owner[GitHubSearchResultString.avatar_url.rawValue] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImgView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
    func inject(with presenter: FetchedDataShowViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter.view = self
    }
}

extension FetchedDataShowViewController: FetchedDataShowViewPresenterOutput {
    
}
