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
        
       var repoDataArray = [RepoData]()
        
        getTrendingData { repoItemsArray in
            
            for repoItem in repoItemsArray {
               
                self.returnRepoDataItem(repoItem: repoItem) { repoDataItem in
                   
                    if repoDataArray.count < 9 {
                        
                        repoDataArray.append(repoDataItem)
                        
                    }else {
                       // sort repo by number of forks
                        let sortedArray = repoDataArray.sorted { (repo1, repo2) -> Bool in

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
            
           
        }

    }
    
    
    func returnRepoDataItem(repoItem : RepoItems , completion : @escaping (_ repoDataItem : RepoData) -> ()) {
        
 
        self.downloadImage(imageUrl: repoItem.owner!.avatarUrl!) { image in
 
            self.downloadContributorsNumb(contributorUrl: repoItem.contributorsUrl!) { contributorsNum in
 
 
                let newItem : RepoData = RepoData(repoImage: image, name: repoItem.name!, description: repoItem.description!, numberOfForks: repoItem.numberOfForks!, language: repoItem.language!, numOfContributors: contributorsNum, repoUrl: repoItem.repoUrl!)
                             
                completion(newItem)
 
                             }
                         }
    }
    
    
    private func downloadImage(imageUrl : String , completion : @escaping (_ image : UIImage)-> ()){
        
        Alamofire.request(imageUrl).responseImage { imageResponse in
            
            guard let image = imageResponse.result.value else {return}
            
            completion(image)
        }
        
    }
    
    
    private func downloadContributorsNumb(contributorUrl : String , completion : @escaping (_ contributorsNum : Int) -> ()) {
        
        Alamofire.request(contributorUrl).responseJSON { response in
            
            guard let json = response.result.value as? [Dictionary<String,Any>] else {return}
            
            if !json.isEmpty {
                
                completion(json.count)
            }
        }
    }
}
