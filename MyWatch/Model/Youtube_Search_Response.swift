//
//  YoutubeSearchResponse.swift
//  MyWatch
//
//  Created by Amir Malamud on 13/12/2022.
//

import Foundation

struct Youtube_Search_Response: Codable {
    
    let items: [Video_Element]
    
}

struct Video_Element : Codable  {
    
    let id: id_Video_Element
    
}

struct id_Video_Element: Codable {
    
    let kind: String
    let videoId: String
}
