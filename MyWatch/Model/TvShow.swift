//
//  TvShow.swift
//  MyWatch
//
//  Created by Amir Malamud on 07/02/2023.
//

import Foundation

struct TvShow: Codable {
    
    let id: Int
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
}

struct TvShowResponse: Codable {
    let results: [TvShow]
}
