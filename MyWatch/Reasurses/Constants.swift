//
//  Constants.swift
//  GamesStore_UIKit
//
//  Created by Amir Malamud on 10/11/2022.
//

import Foundation

struct S{
    
    struct Identifier{
        static let CollectionViewTableViewCell = "CollectionViewTableViewCell"
        static let ShowCollectionViewCell =      "ShowCollectionViewCell"
        static let ShowTableViewCell =           "ShowTableViewCell"
    }
   
    struct ButtonName {
        static let btn_play_title =      "play"
        static let btn_download_title =  "download"
    }
    
    struct title {
        static let appName  =   "WyWatch"
        static let upcoming =   "Upcoming"
        static let search   =   "Search"
        static let Register =   "Register"
    }
    
    struct placeHolder {
        static let Email    =    "Email"
        static let Password =    "Password"
    }
    
    struct picName{
        static let Logo = "Logo"
    }
    
    struct HomeView_sectionTitles{
        
        static let Trending       =  "Trending today"
        static let Popular        =  "Most popular"
        static let Top_Rated      =  "Top rated"
        static let RecentlyAdded  =  "Recently Added"
        
        static let Upcoming       =  "Upcoming Movies"


    }
    
    
    struct SearchStrings {
        static let searchPlaceHolder = "Search for a Movie or a Tv show"
    }
    
    
    struct API_TV {
        static let API_KEY = "606d075a4fbbc18c603c1dbf8c440945"
        static let baseURL = "https://api.themoviedb.org/3/"
        static let imgURL = "https://image.tmdb.org/t/p/w500/"


        
        struct Movies{
            
            static let getTrendingMovies      = "\(baseURL)trending/movie/day?api_key=\(API_KEY)&language=en-US"
            
            static let getUpcomingMovies      = "\(baseURL)movie/upcoming?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getPopularMovies       = "\(baseURL)movie/popular?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getTopRatedMovies      = "\(baseURL)movie/top_rated?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getRecentlyAddedMovies = "\(baseURL)movie/latest?api_key=\(API_KEY)&language=en-US&page=1"


            static let getDiscoverMovies = "\(baseURL)discover/movie?api_key=\(API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        }
        
        
        struct TVshows{
            
            static let getTrendingTvShows = "\(baseURL)trending/tv/day?api_key=\(API_KEY)&language=en-US"
            
            static let getUpcomingTvShows = "\(baseURL)tv/upcoming?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getPopularTvShows  = "\(baseURL)tv/popular?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getTopRatedTvShows = "\(baseURL)tv/top_rated?api_key=\(API_KEY)&language=en-US&page=1"
            
            static let getRecentlyAddedTvShows = "\(baseURL)tv/latest?api_key=\(API_KEY)&language=en-US&page=1"

            static let getDiscoverTvShows = "\(baseURL)discover/tv?api_key=\(API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        }
            
        // DO : search
        static let doSearch = "\(baseURL)search/movie?api_key=\(API_KEY)&query=)"
        
    }
    
    
    
    struct API_YOUTUBE {
           static let API_KEY   = "AIzaSyB21Aec3U89GUmg5d3wgrN9pbQ_iA2MXg4"
           static let searchURL = "https://youtube.googleapis.com/youtube/v3/search?"
           static let viewURL    = "https://www.youtube.com/embed/"
    }
}
