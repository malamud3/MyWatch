//
//  APICaller_TV.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 05/12/2022.
//

import Foundation


class APICaller_TV{
    static let shared = APICaller_TV()
    
    enum APIError: Error{
        case failledTogetData
    }
    
    func getTrendingTVShows(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.TVshows.getTrendingTvShows) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                print(results)
                self.getTvShowData(with: results.results[0].id)
                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
    
    func getPopularTVShows(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.TVshows.getPopularTvShows) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)

                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }

    
    func getTopRatedTVShows(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.TVshows.getTrendingTvShows) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
    
    

    
    func getUpcomingTVShows(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.TVshows.getUpcomingTvShows) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                
                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }

          
    func getRecentlyAddedTvShows(completion: @escaping (Result<[Movie], Error>) -> Void){

        guard let url = URL(string: S.API_TV.TVshows.getRecentlyAddedTvShows) else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))

            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
    

    
    // @ GET: Trending(Most views in 24h) -> return [Movie] || Error
    func getTvShowData(with id: Int){
        print(id)
        guard let url = URL(string: "\(S.API_TV.baseURL)tv/\(id)?api_key=\(S.API_TV.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                print(json)

              //  completion(.success(results.results))
                
            } catch{
             //   completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
    
   
  
}
