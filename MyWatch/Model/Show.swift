//
//  Show.swift
//  MyWatch
//
//  Created by Amir Malamud on 05/12/2022.
//

import Foundation



//Genral
struct Show: Codable, Hashable {
    
    let id: Int
    let title: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    let genre_ids: [Int]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
}

//Main Page -> recently Added Movie
struct recentlyAddedMovie: Codable {
    
    let id: Int
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]

}


//Main Page -> recently Added tv and upComingShow
struct upComingShow: Codable {
    
    let first_air_date: String?
    let id: Int
    let name: String?
    let poster_path: String?
    let overview: String?
    let genre_ids: [Int]
    
}

struct MoviesResponse: Codable {
    let results: [Show]
}

struct upComingResponse: Codable {
    let results: [upComingShow]
}

struct recentlyAddedResponse: Codable {
    let results: [recentlyAddedMovie]
}
