//
//  Show.swift
//  MyWatch
//
//  Created by Amir Malamud on 05/12/2022.
//

import Foundation




struct Show: Codable {
    
    let id: Int
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
}

struct upComingShow: Codable {
    
    let first_air_date: String?
    let id: Int
    let name: String?
    let poster_path: String?
    let overview: String?
}

struct MoviesResponse: Codable {
    let results: [Show]
}

struct upComingResponse: Codable {
    let results: [upComingShow]
}
