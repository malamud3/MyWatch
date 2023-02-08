//
//  APICaller_Show.swift
//  MyWatch
//
//  Created by Amir Malamud on 06/02/2023.
//

import Foundation


enum APIError: Error{
    case failledTogetData
}
protocol APICaller_Show{

    func getTrending(completion: @escaping (Result<[Show], Error>) -> Void)
    func getPopular (completion:  @escaping  (Result<[Show], Error>) -> Void)
    func getTopRated(completion: @escaping (Result<[Show], Error>) -> Void)
    func getUpcoming(completion: @escaping (Result<[Show], Error>) -> Void)
}

extension APICaller_Show {
    
    /* Genaral*/
    func doSearch(with query: String ,completion: @escaping (Result<[Show], Error>) -> Void){
        
        //Returns the character set for characters allowed in a user URL subcomponent.
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(S.API_TV.doSearch)\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                print(results)
                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
}
