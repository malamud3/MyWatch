//
//  APICaller_Movie.swift
//  MyWatch
//
//  Created by Amir Malamud on 06/02/2023.
//

import Foundation

class APICaller_Movie: APICaller_Show{


    static let shared = APICaller_Movie()
    
    enum APIError: Error{
        case failledTogetData
    }
    
    // @ GET: Trending(Most views in 24h) -> return [Show] || Error
    func getTrending(dataPage Mypage: Int, Ganerfilter MyGaner: Int16, completion: @escaping (Result<[Show], Error>) -> Void) {
        
        var urlString = "\(S.API_TV.Movies.getTrendingMovies)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        
        guard let url = URL(string: urlString) else { return }
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            print(url)
            if let error = error {
                print("URLSession error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.failledTogetData))
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

    //@ GET: Upcoming -> return [Show] || Error
    
    func getUpcoming(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[upComingShow], Error>) -> Void){
        
        var urlString = "\(S.API_TV.Movies.getUpcomingMovies)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                let fixData = self.mapShowsToUpcomingShows(shows: results.results)

                completion(.success(fixData))
            } catch{
                completion(.failure(APIError.failledTogetData))

            }
        }
        task.resume()
    }
    
    /* Movies */
    //@ GET: Popular -> return [Show] || Error
    func getPopular(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
        
        
        var urlString = "\(S.API_TV.Movies.getPopularMovies)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failledTogetData))
            }
        }
        task.resume()
    }

    /* Movies */
    //@ GET: TopRate -> return [Show] || Error
    func getTopRated(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
        
        var urlString = "\(S.API_TV.Movies.getTopRatedMovies)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(.success(results.results))
            }catch{
                    completion(.failure(APIError.failledTogetData))
                }
            }
        task.resume()
        }
    
    /* Movies */
    // @ GET:
    
    func getRecentlyAdded(dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void){
        
        var urlString = "\(S.API_TV.Movies.getRecentlyAddedMovies)&page=\(Mypage)"
        
        if MyGaner != -1 {
            urlString += "&with_genres=\(MyGaner)"
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(recentlyAddedResponse.self, from: data)
                let fixData = self.mapRecentlyAddedMovieToShows(shows: results.results)
                    completion(.success(fixData))
            }catch{
                    completion(.failure(APIError.failledTogetData))
                }
            }
        task.resume()
        }
    
    func doSearch(dataPage Mypage: Int, with query: String, completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(S.API_TV.doSearchMovie)\(query)&page=\(Mypage)") else { return }
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
