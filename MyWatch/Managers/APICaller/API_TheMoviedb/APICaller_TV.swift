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
    
    func getTrending(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
                
        var urlString = "\(S.API_TV.TVshows.getTrendingTvShows)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error = error {
                print("URLSession error: \(error)")
                completion(.failure(error))
                return
            }
            
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
    
    func getPopular(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
        
        var urlString = "\(S.API_TV.TVshows.getPopularTvShows)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
    
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
            //    print(results.results)
                completion(.success(results.results))
                
            } catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }

    
    func getTopRated(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
                
        var urlString = "\(S.API_TV.TVshows.getTrendingTvShows)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        
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
    
    

    
    func getUpcoming(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[upComingShow], Error>) -> Void){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: date)

        var urlString = "\(S.API_TV.TVshows.getUpcomingTvShows)\(today)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        print(url)
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
    
    func getRecentlyAdded(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: date)
        
        var urlString = "\(S.API_TV.TVshows.getRecentlyAddedTvShows)\(today)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
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
        guard let url = URL(string: "\(S.API_TV.baseURL)tv/\(id)?api_key=\(S.API_TV.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                _ = try JSONSerialization.jsonObject(with: data, options: [])
                

              //  completion(.success(results.results))
                
            } catch{
             //   completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }
    
    func doSearch(dataPage Mypage: Int, with query: String, completion: @escaping (Result<[Show], Error>) -> Void) {
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
