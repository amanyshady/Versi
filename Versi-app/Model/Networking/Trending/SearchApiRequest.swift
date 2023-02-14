//
//  SearchApiRequest.swift
//  Versi-app
//
//  Created by Amany Shady on 05/02/2023.
//

import Foundation
import UIKit


protocol SearchApiRequestProtocol {
 
    func getSearchRepoData(searchTxt : String , completion : @escaping (_ repoDataArray : [RepoData]) -> ())
    
}

class SearchApiRequest : ApiService<TrendingNetworking> , SearchApiRequestProtocol {
    
    func getSearchRepoData(searchTxt : String , completion : @escaping (_ repoDataArray : [RepoData]) -> ()) {
        
        self.fetchData(apiTarget: .searchRepo(searchTxt: searchTxt), apiModel: RepoModule.self) { repoItemArray, error in
            
            if error != nil {
                
            }else {
                
                var finalRepoArray = [RepoData]()
                guard let returnRepoData = repoItemArray?.items else {return}
                
                for item in returnRepoData {
                 
                    guard let name = item.name ,
                         let description = item.description,
                          let numOfForks = item.numberOfForks,
                          let language = item.language,
                          let repoUrl = item.repoUrl else {continue}
                    
                    let repoItem =  RepoData(repoImage: UIImage(named: "elantra-1080p")!, name: name, description: description, numberOfForks: numOfForks, language: language, numOfContributors: 0, repoUrl: repoUrl)
                    
                   print("repo item",repoItem)
                    finalRepoArray.append(repoItem)
                    
                }
              
                
                completion(finalRepoArray)
            }
            
        }
    }
}
