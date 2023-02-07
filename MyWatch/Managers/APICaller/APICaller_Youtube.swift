//
//  APICaller_Youtube.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 13/12/2022.
//

import Foundation

import GoogleAPIClientForREST
import GoogleSignIn

// Set up the YouTube API client
let youtubeService = GTLRYouTubeService()

class APICaller_Youtube{
    static let shared = APICaller_Youtube()
    private let youtubeQueue = DispatchQueue(label: "youtubeQueue")
    // other code
    func getTrailer(for movieTitle: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.global().async {
            // Use the YouTube API to search for a trailer for the given movie
            let query = GTLRYouTubeQuery_SearchList.query(withPart: ["id"])
            query.q = "\(movieTitle) trailer"
            query.type = ["video"]
            query.videoDefinition = "high"
            query.maxResults = 1
            query.fields = "items(id(videoId))"
            
            youtubeService.apiKey = S.API_YOUTUBE.API_KEY
            
            youtubeService.executeQuery(query) { (ticket, response, error) in
                if let error = error {
                    print("Error searching for trailer: \(error.localizedDescription) ")
                    completion(nil)
                    return
                }
                
                guard let response = response as? GTLRYouTube_SearchListResponse,
                      let videoId = response.items?.first?.identifier?.videoId else {
                    completion(nil)
                    return
                }
                
                // Return the URL of the trailer video
                DispatchQueue.main.async {
                    completion("\(S.API_YOUTUBE.viewURL)\(videoId)")
                }
            }
        }
    }
}
