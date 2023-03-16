//
//  APICaller_Show.swift
//  MyWatch
//
//  Created by Amir Malamud on 06/02/2023.
//

import Foundation



protocol APICaller_Show {
    
    func getTrending        (dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void)
    func getPopular         (dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void)
    func getTopRated        (dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void)
    func getUpcoming        (dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[upComingShow], Error>) -> Void)
    func getRecentlyAdded   (dataPage Mypage: Int,Ganerfilter MyGaner: Int16,completion: @escaping (Result<[Show], Error>) -> Void)
    func doSearch           (with query: String, completion: @escaping ( Result<[Show], Error> ) -> Void )
}
    
extension APICaller_Show {
    
    func mapShowsToUpcomingShows(shows: [Show]) -> [upComingShow] {
        return shows.map { show in
            upComingShow(first_air_date: show.release_date,
                          id: show.id,
                          name: show.original_name ?? show.original_title,
                          poster_path: show.poster_path,
                          overview: show.overview,
                          genre_ids: show.genre_ids)
        }
    }
    
    func mapUpcomingShowsToShows(shows: [upComingShow]) -> [Show] {
        return shows.map { show in
            Show (id: show.id,
                  original_name: "",
                  original_title: show.name,
                  poster_path: show.poster_path,
                  overview: show.overview,
                  vote_count: 0,
                  release_date: show.first_air_date,
                  vote_average: 0,
                  genre_ids: show.genre_ids)
        }
    }
    
    func mapRecentlyAddedMovieToShows(shows: [recentlyAddedMovie]) -> [Show] {
        return shows.map { show in
            Show (id: show.id,
                  original_name: "",
                  original_title: show.original_title,
                  poster_path: show.poster_path,
                  overview: show.overview,
                  vote_count: 0,
                  release_date: show.release_date,
                  vote_average: 0,
                  genre_ids: show.genre_ids
            )
        }
    }
}
