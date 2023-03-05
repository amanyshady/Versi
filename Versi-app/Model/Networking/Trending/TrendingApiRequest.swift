//
//  TrendingApiRequest.swift
//  Versi-app
//
//  Created by Amany Shady on 25/01/2023.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire



protocol TrendingApiRequestProtocol {
    
    
    func getTrending(completion : @escaping ([RepoData]) -> Void)
}

class TrendingApiRequest : ApiService<TrendingNetworking> , TrendingApiRequestProtocol {
    
    
    
    
    
    private func getTrendingData (completion : @escaping (_ repoItemsArray : [RepoItems] ) -> ()) {
        
        self.fetchData(apiTarget: .getTrending, apiModel: RepoModule.self) { response,error  in
            
            if error != nil {
                
                print("error in return data",error)
                
            }else {
                
                var repoItemsArray = [RepoItems]()
                
                for repoItem in response!.items! {
                    
                    if repoItemsArray.count <= 9 {
                        
                        guard let name = repoItem.name ,
                              let description = repoItem.description,
                              let numberOfForks = repoItem.numberOfForks ,
                              let language = repoItem.language ,
                              let contributorsUrl = repoItem.contributorsUrl ,
                              let repoUrl = repoItem.repoUrl,
                              let owner = repoItem.owner,
                              let avatarUrl = owner.avatarUrl   else { continue }
                        
                        let repoNewItem : RepoItems =  RepoItems(owner: owner, name: name, description: description, numberOfForks: numberOfForks, language: language, contributorsUrl: contributorsUrl, repoUrl: repoUrl)
                        
                        repoItemsArray.append(repoNewItem)
                        
                    }else {
                        
                        break
                    }
                    
                }
                completion(repoItemsArray)
            }
            
        }
    }
    
    
    func getTrending(completion : @escaping ([RepoData]) -> Void) {
        
      
        
        getTrendingData { repoItemsArray in
            
            self.fetchContrNumAndImag(repoArray: repoItemsArray) { repoList in
                
                
                // sort repo by number of forks
                let sortedArray = repoList.sorted { (repo1, repo2) -> Bool in
                    
                    if repo1.numberOfForks! > repo2.numberOfForks! {
                        
                        return true
                        
                    }else {
                        
                        return false
                    }
                }
                
                completion(sortedArray)
                
            }
        
        }
        
    }
    

    
    private func fetchContrNumAndImag(repoArray : [RepoItems] , completion : @escaping ([RepoData]) -> () ) {
        
        var finalRepoList = [RepoData]()
        var group = DispatchGroup()
        
        for repo in repoArray {
            
            let newItem : RepoData = RepoData( name: repo.name!, description: repo.description!, numberOfForks: repo.numberOfForks!, language: repo.language!, repoUrl: repo.repoUrl!)
            
            group.enter()
            
            // fetch image url
            Alamofire.request(repo.owner!.avatarUrl!).responseImage { response in
                
                guard let image = response.result.value else {return}
                
                newItem.repoImage = image
                
                group.leave()
                
                
            }
            
            group.enter()
            // fetch contrib num
            Alamofire.request(repo.contributorsUrl!).responseJSON { response in
                
                guard let json = response.result.value as? [Dictionary<String,Any>] else {return}
                
                if !json.isEmpty {
                    
                    newItem.numOfContributors = json.count
                    
                    group.leave()
                }
            }
            
            
            finalRepoList.append(newItem)
            
        }
        
        
        group.notify(queue: .main) {
            completion(finalRepoList)
        }
        
    }
}
