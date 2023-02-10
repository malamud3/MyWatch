//
//  APICaller_Show.swift
//  MyWatch
//
//  Created by Amir Malamud on 06/02/2023.
//

import Foundation



protocol APICaller_Show{
    
    func getTrending(completion: @escaping (Result<[Show], Error>) -> Void)
    func getPopular(completion: @escaping (Result<[Show], Error>) -> Void)
    func getTopRated(completion: @escaping (Result<[Show], Error>) -> Void)
    func getUpcoming(completion: @escaping (Result<[upComingShow], Error>) -> Void)
    func getRecentlyAdded(completion: @escaping (Result<[Show], Error>) -> Void)
    func doSearch(with query: String, completion: @escaping (Result<[Show], Error>) -> Void)
}
extension APICaller_Show{
    
    func mapShowsToUpcomingShows(shows: [Show]) -> [upComingShow] {
        return shows.map { show in
            upComingShow(first_air_date: show.release_date,
                          id: show.id,
                          name: show.original_name ?? show.original_title,
                          poster_path: show.poster_path,
                          overview: show.overview)
        }
    }
}
