//
//  YoutubeSearchResponse.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 13/12/2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    
    let items: [VideoElement]
    
}

struct VideoElement : Codable  {
    
    let id: idVideoElement
    
}

struct idVideoElement: Codable {
    
    let kind: String
    let videoId: String
}
