//
//  Constants.swift
//  GamesStore_UIKit
//
//  Created by Amir Malamud on 10/11/2022.
//

import Foundation



struct S{
        
    struct genresIndex{
        /*
         https://developers.themoviedb.org/3
        */
        
        static let TV_genres: [Int16: String] = [
        /*
        https://api.themoviedb.org/3/genre/tv/list?api_key=606d075a4fbbc18c603c1dbf8c440945&language=en-US
        */

            10759    :  "Action & Adventure",
            16       :  "Animation",
            35       :  "Comedy",
            80       :  "Crime",
            99       :  "Documentary",
            18       :  "Drama",
            10751    :  "Family",
            9648     :  "Mystery",
            10765    :  "Science Fiction",
            37       :  "Western",
            10768    :  "War & Politics"
        ]
        
        static let Movie_genres: [Int16: String] = [

            28       :  "Action",
            12       :  "Adventure",
            16       :  "Animation",
            35       :  "Comedy",
            80       :  "Crime",
            99       :  "Documentary",
            18       :  "Drama",
            10751    :  "Family",
            14       :  "Fantasy",
            36       :  "History",
            27       :  "Horror",
            9648     :  "Mystery",
            10749    :  "Romance",
            878      :  "Science Fiction",
            10770    :  "TV Movie",
            53       :  "Thriller",
            37       :  "Western"
        ]
     
    }
    
    struct Identifier{
        static let CollectionViewTableViewCell = "CollectionViewTableViewCell"
        static let ShowCollectionViewCell      = "ShowCollectionViewCell"
        static let ShowTableViewCell           = "ShowTableViewCell"
        static let GenreTableViewCell          = "GenreTableViewCell"
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
        static let Icon_apple = "Icon_apple"
        static let Icon_google = "Icon_google"

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
            static let getGenreMoviesIndex    =  "\(baseURL)movie/list?api_key=\(API_KEY)&language=en-US"
              
            static let getTrendingMovies      =  "\(baseURL)trending/movie/day?api_key=\(API_KEY)&language=en-US"
            
            static let getUpcomingMovies      =  "\(baseURL)movie/upcoming?api_key=\(API_KEY)"
            
            static let getPopularMovies       =  "\(baseURL)movie/popular?api_key=\(API_KEY)&language=en-US"
            
            static let getTopRatedMovies      =  "\(baseURL)movie/top_rated?api_key=\(API_KEY)&language=en-US"
            
            static let getRecentlyAddedMovies =
            "\(baseURL)discover/movie?api_key=\(API_KEY)&sort_by=release_date.desc&include_adult=false&page=1&year=2023"

        }
        
        
        struct TVshows{
            
            static let getGenreTVshowsIndex      =
               "\(baseURL)movie/list?api_key=\(API_KEY)&language=en-US"
            
            static let getTrendingTvShows = "\(baseURL)trending/tv/day?api_key=\(API_KEY)&language=en-US"
            
            static let getUpcomingTvShows = "\(baseURL)discover/tv?api_key=\(API_KEY)&include_null_first_air_dates=false&sort_by=first_air_date.desc&first_air_date.gte="
           
            static let getPopularTvShows  = "\(baseURL)tv/popular?api_key=\(API_KEY)&language=en-US"
            
            static let getTopRatedTvShows = "\(baseURL)tv/top_rated?api_key=\(API_KEY)&language=en-US"
            
            static let getRecentlyAddedTvShows = "\(baseURL)discover/tv?api_key=\(API_KEY)&include_null_first_air_dates=false&sort_by=first_air_date.desc&first_air_date.lte="
            
        }
            
        // DO : search
        static let doSearchMovie = "\(baseURL)search/movie?api_key=\(API_KEY)&query=)"
        static let doSearchTv = "\(baseURL)search/tv?api_key=\(API_KEY)&query=)"

        
    }
    
    
    
    struct API_YOUTUBE {
           static let API_KEY   = "AIzaSyB21Aec3U89GUmg5d3wgrN9pbQ_iA2MXg4"
           static let searchURL = "https://youtube.googleapis.com/youtube/v3/search?"
           static let viewURL    = "https://www.youtube.com/embed/"
    }
}
