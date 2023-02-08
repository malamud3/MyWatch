//
//  APICaller_TV.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 05/12/2022.
//

import Foundation


class APICaller_TV: APICaller_Show{
    static let shared = APICaller_TV()
    
    enum APIError: Error{
        case failledTogetDatas
    }
    
    func getTrending(completion: @escaping (Result<[Show], Error>) -> Void){
        
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
    
    func getPopular(completion: @escaping (Result<[Show], Error>) -> Void){
        
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

    
    func getTopRated(completion: @escaping (Result<[Show], Error>) -> Void){
        
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
    
    

    
    func getUpcoming(completion: @escaping (Result<[Show], Error>) -> Void){
        
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

          
    func getRecentlyAdded(completion: @escaping (Result<[Show], Error>) -> Void){

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
