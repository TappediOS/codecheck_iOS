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
        
        guard let owner = repo[GitHubSearchResultString.owner.rawValue] as? [String: Any] else { return }
        guard let imageURLStr = owner[GitHubSearchResultString.avatar_url.rawValue] as? String else { return }
        guard let url = URL(string: imageURLStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            guard let userImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.ImgView.image = userImage
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
