//
//  APICaller_Movie.swift
//  MyWatch
//
//  Created by Amir Malamud on 06/02/2023.
//

import Foundation

class APICaller_Movie{
    static let shared = APICaller_Movie()
    
    enum APIError: Error{
        case failledTogetData
    }
    
    /* Movies */
    // @ GET: Trending(Most views in 24h) -> return [Show] || Error
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
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
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: S.API_TV.Movies.getUpcomingMovies) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
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
    //@ GET: Popular -> return [Show] || Error
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
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
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
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

    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: S.API_TV.Movies.getDiscoverMovies) else {return}

        
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
    
    
}
