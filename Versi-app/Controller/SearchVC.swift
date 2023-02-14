//
//  SearchVC.swift
//  Versi-app
//
//  Created by Amany Shady on 12/01/2023.
//

import UIKit
import RxCocoa
import RxSwift

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTxtField: UITextField!

    @IBOutlet weak var tableView: UITableView!
    
    
    let disposeBag = DisposeBag()
    
    let searchApiRequest : SearchApiRequestProtocol?
    var dataSource : PublishSubject = PublishSubject<[RepoData]>()
    
    
    init(searchApiRequest : SearchApiRequestProtocol) {
        
        self.searchApiRequest = searchApiRequest
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      
        self.searchApiRequest = SearchApiRequest()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setUp()
        bindSearchElements()
        bindDataSource()
      
    }
    
    
    func bindSearchElements() {
        
        searchTxtField.rx.text.orEmpty
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .bind { text in
                
                if text == "" {
                
                    self.dataSource.onNext([])
                    
                }else {
                    self.searchService(text: text)
                }
               
            }.disposed(by: disposeBag)

    }
    
    
    func searchService(text : String) {
    
        searchApiRequest!.getSearchRepoData(searchTxt: text) { repoDataArray in
        print("return array",repoDataArray)
            self.dataSource.onNext(repoDataArray)
        }
        
    }
    
    func bindDataSource() {

        dataSource.bind(to: tableView.rx.items(cellIdentifier: "searchCell")){ (row , repoData : RepoData , cell : SearchCell) in

            cell.configCell(repo: repoData)

        }.disposed(by: disposeBag)
    }
    
    func setUp() {
        
        searchTxtField.roundedBorderTextField()
    }

}

extension SearchVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else{ return }
       
        let repoUrl = cell.repoUrl
        self.presentSFSafariVCFor(url: repoUrl!)
    }
}
