//
//  TrendingFeedVC.swift
//  Versi-app
//
//  Created by Amany Shady on 12/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshController = UIRefreshControl()
    
    var dataSource : PublishSubject = PublishSubject<[RepoData]>()
    var disposeBag = DisposeBag()
    private let trendingApiRequest : TrendingApiRequestProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setRefreshController()
        fetchTrendingData()
        bindTableViewDataSource()
    }
    
    
    init(trendingApiRequest :TrendingApiRequestProtocol ) {
        
        self.trendingApiRequest = trendingApiRequest
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       
        self.trendingApiRequest = TrendingApiRequest()
        super.init(coder: coder)
    }
    
    @objc func fetchTrendingData() {
        
          trendingApiRequest!.getTrending { repoArray in
            self.dataSource.onNext(repoArray)
            self.refreshController.endRefreshing()
        }
    }
    
    private func setRefreshController() {
        
        tableView.refreshControl = refreshController
        refreshController.tintColor = UIColor.blue
        refreshController.attributedTitle = NSAttributedString(string: "Fetching Data" , attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue , NSAttributedString.Key.font : UIFont(name: "Helvetica Bold", size: 15)!])
        
        //action will happen when swip the refresh controll
        
        refreshController.addTarget(self, action: #selector(fetchTrendingData), for: .valueChanged)
    }
    
    
    private func bindTableViewDataSource() {
      
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "repoCell")) { (row , repo : RepoData ,cell : trendingRepoCell ) in
            
            cell.configureRepo(repo: repo)
            
            
        }.disposed(by: disposeBag)
        
    }


}
