//
//  trendingRepoCell.swift
//  Versi-app
//
//  Created by Amany Shady on 18/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

class trendingRepoCell: UITableViewCell {
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var repoNameLbl: UILabel!
    
    @IBOutlet weak var repoDescLbl: UILabel!
    
    @IBOutlet weak var repoImageView: UIImageView!
    
    @IBOutlet weak var numberOfForksLbl: UILabel!
    
    @IBOutlet weak var languageLbl: UILabel!
    
    @IBOutlet weak var numberOfContributors: UILabel!
    
    @IBOutlet weak var viewReadmeBtn: UIButton!
    
    var repoUrl : String?

    let disposeBag = DisposeBag()
    
    override func layoutSubviews() {
        
        viewReadmeBtn.buttonRoundedBorder()
        
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowRadius = 5.0
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowOpacity = 0.25
    }
    
    func configureRepo(repo : RepoData) {
        
        repoImageView.image = repo.repoImage
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        numberOfForksLbl.text = String (repo.numberOfForks!)
        languageLbl.text = repo.language
        numberOfContributors.text = String (repo.numOfContributors!)
        
        repoUrl = repo.repoUrl
        
        // open safari with url when click on read me button
        viewReadmeBtn.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.window?.rootViewController?.presentSFSafariVCFor(url: self.repoUrl!)
            }).disposed(by: disposeBag)
        
    }

    
}
