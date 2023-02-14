//
//  SearchCell.swift
//  Versi-app
//
//  Created by Amany Shady on 05/02/2023.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var trendingNameLbl: UILabel!
    
    @IBOutlet weak var trendingDescLbl: UILabel!
    
    @IBOutlet weak var numOfForksLbl: UILabel!
    
    @IBOutlet weak var languageLbl: UILabel!
    
    @IBOutlet weak var roundImageView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    var repoUrl : String?
    
    
    override func layoutSubviews() {
        
        backView.layer.cornerRadius = 15
    
        roundImageView.imageRoundedBorder()
    }
    
    
    func configCell(repo : RepoData) {
        trendingNameLbl.text = repo.name
        trendingDescLbl.text = repo.description
        numOfForksLbl.text = String(describing: repo.numberOfForks!)
        languageLbl.text = repo.language
        repoUrl = repo.repoUrl
    }
}
