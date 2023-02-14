//
//  Repo.swift
//  Versi-app
//
//  Created by Amany Shady on 18/01/2023.
//

import Foundation
import UIKit


class RepoModule : Decodable {
    
    var items : [RepoItems]?
    
    enum CodingKeys: String, CodingKey {

        case items
    }
}

class RepoItems: Decodable {
    
     var owner  : Owner?
     var name  : String?
     var description  : String?
     var numberOfForks  : Int?
     var language  : String?
     var contributorsUrl : String?
     var repoUrl : String?
   
    
    init(owner: Owner, name: String, description: String, numberOfForks: Int, language: String, contributorsUrl: String, repoUrl: String) {
        
        self.owner = owner
        self.name = name
        self.description = description
        self.numberOfForks = numberOfForks
        self.language = language
        self.contributorsUrl = contributorsUrl
        self.repoUrl = repoUrl
    }
    
    
    enum CodingKeys: String, CodingKey {

        case owner, name , description , language
        case numberOfForks = "forks_count"
        case contributorsUrl = "contributors_url"
        case repoUrl = "html_url"
    }


}


class Owner : Decodable {
    
    var avatarUrl : String?
    
    
    enum CodingKeys: String, CodingKey {

        case avatarUrl = "avatar_url"
    }
}

// final data item sent to table cell
class RepoData {
  
    var repoImage  : UIImage?
    var name  : String?
    var description  : String?
    var numberOfForks  : Int?
    var language  : String?
    var numOfContributors : Int?
    var repoUrl : String?
  
   init(repoImage : UIImage , name : String,description : String ,numberOfForks : Int , language : String , numOfContributors : Int , repoUrl : String){

       self.repoImage = repoImage
       self.name = name
       self.description = description
       self.numberOfForks = numberOfForks
       self.language = language
       self.numOfContributors = numOfContributors
       self.repoUrl = repoUrl
   }
        
}


