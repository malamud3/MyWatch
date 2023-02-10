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
    
    

    
    func getUpcoming(with Mypage: Int,completion: @escaping (Result<[upComingShow], Error>) -> Void){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: date)

        guard let url = URL(string: "\(S.API_TV.TVshows.getUpcomingTvShows)\(today)&page=\(Mypage)") else {return}
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
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: date)
        
        guard let url = URL(string: "\(S.API_TV.TVshows.getRecentlyAddedTvShows)\(today)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(upComingResponse.self, from: data)
                let fixedData = self.mapUpcomingShowsToShows(shows: results.results)

                completion(.success(fixedData))
                
                
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
