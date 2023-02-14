//
//  ApiService.swift
//  Versi-app
//
//  Created by Amany Shady on 24/01/2023.
//

import Foundation
import Alamofire


class ApiService<T : ApiTarget> {
    
    
    func fetchData<M : Decodable>( apiTarget : T , apiModel : M.Type , completion :@escaping (M?, Error?) -> Void)  {
        
        let httpMethod = Alamofire.HTTPMethod(rawValue: apiTarget.httpMethod.rawValue)
        let hearders = apiTarget.headers ?? [:]
        let parameters = buildParameters(task: apiTarget.task)
        Alamofire.request(apiTarget.baseUrl + apiTarget.path , method: httpMethod! , parameters: parameters.0, encoding: parameters.1, headers: hearders).responseJSON { response in
            
            guard let data = response.data else {
                return
            }
            
            switch response.result {
                
            case .success(_) :
                
                do {
                    
                   let responseData =  try JSONDecoder().decode(M.self, from: data)
                    
                    completion(responseData , nil)
                    
                } catch let jsonError {
                    
                    completion(nil , jsonError)
                    
                }
                
            case .failure(let error) :
                
                completion(nil , error)
                
            }
            
        }
        
    }
    
    
   private func buildParameters(task : Task) -> ([String : Any],ParameterEncoding) {
      
        switch task {
            
        case .requestPlain :
            
            return ([:], URLEncoding.default)
            
        case .requestParameters(parameters: let parameters, encoding: let parameterEncoding):
            
            return (parameters,parameterEncoding)
        }
        
    }
    
}
