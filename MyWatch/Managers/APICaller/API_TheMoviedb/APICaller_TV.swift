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
        case failledTogetData
    }
    
    func getTrending(completion: @escaping (Result<[Show], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.TVshows.getTrendingTvShows) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
//                self.getTvShowData(with: results.results[0].id)
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
    
    

    
    func getUpcoming(completion: @escaping (Result<[upComingShow], Error>) -> Void){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: date)
        
        guard let url = URL(string: "\(S.API_TV.TVshows.getUpcomingTvShows)\(today)&page=1&timezone=Israel%2FTel_Aviv&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(upComingResponse.self, from: data)
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
    
    func doSearch(with query: String, completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(S.API_TV.doSearchTv)\(query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failledTogetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
}
