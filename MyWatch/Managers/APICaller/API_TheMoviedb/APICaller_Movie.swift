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
    
    /* Movies */
    // @ GET: Trending(Most views in 24h) -> return [Show] || Error
    func getTrending(completion: @escaping (Result<[Show], Error>) -> Void){
        
        guard let url = URL(string: S.API_TV.Movies.getTrendingMovies) else {return}
        
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

    /* Movies */
    //@ GET: Upcoming -> return [Show] || Error
    
    func getUpcoming(with Mypage: Int,completion: @escaping (Result<[upComingShow], Error>) -> Void){
        guard let url = URL(string: "\(S.API_TV.Movies.getUpcomingMovies)&page=\(Mypage)") else {return}
        
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
    func getPopular(completion: @escaping (Result<[Show], Error>) -> Void){
        guard let url = URL(string: S.API_TV.Movies.getPopularMovies) else {return}
        
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
    func getTopRated(completion: @escaping (Result<[Show], Error>) -> Void){
        guard let url = URL(string: S.API_TV.Movies.getTopRatedMovies) else {return}

        
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
    
    func getRecentlyAdded(completion: @escaping (Result<[Show], Error>) -> Void){
        guard let url = URL(string: S.API_TV.Movies.getRecentlyAddedMovies) else {return}

        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(recentlyAddedResponse.self, from: data)
                let fixData = self.mapRecentlyAddedMovieToShows(shows: results.results)
                print(fixData)
                    completion(.success(fixData))
            }catch{
                    completion(.failure(APIError.failledTogetData))
                }
            }
        task.resume()
        }
    
    func doSearch(with query: String, completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(S.API_TV.doSearchMovie)\(query)") else { return }
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
