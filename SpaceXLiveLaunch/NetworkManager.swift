//
//  NetworkManager.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/23/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case launches = "launches/"
    case rockets = "rockets/"
}

struct NetworkManager{

    private let base : String
    
    init(_ base: String) {
        self.base = base
    }
    
    func performRequest<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T,Error>) -> Void){
        
        if let url = URL(string: "\(base)\(endpoint)"){
            
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(error!))
                }
                
                if let safeData = data {
                    
                    let decoder = JSONDecoder()
                    
                    do{
                        //.decode([LaunchModel].self, from: data
                        completion(.success(try decoder.decode(T.self, from: safeData)))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
            
        }
        return
    }
}
