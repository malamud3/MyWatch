//
//  ViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//


import UIKit
import RxSwift

class MainTabBarViewController: UITabBarController {
    
    let showMoviesSubject = PublishSubject<Bool>()
    var showMovies : Bool = true
    let selectedGenreSubject = PublishSubject<Int16>()
    var selectedGenre: Int16 = 0 // default to no genre selected
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        configureNavbar()
        navigationController?.isNavigationBarHidden = false
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpComingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: MyListViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        
        
        // use this to make the icons bold when they are selected
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "play.circle.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.clipboard.fill")
        
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "My List"
        
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        selectedGenreSubject
                    .subscribe(onNext: { [weak self] genre in
                        self?.selectedGenre = genre
                    })
                    .disposed(by: disposeBag)
        
    }
    // NAV -> Porfile, LOGO-> FirstPage
    
    private func configureNavbar(){
        
        let profileMangerBtn =
        UIBarButtonItem ( image   :   UIImage(systemName: "person"),
                          style   :   .done,
                          target  :   self,
                          action  :   #selector(handleLogin)
        )
        
        let  moviesBtn =
        UIBarButtonItem ( title   :   "Movies",
                          style   :   .plain,
                          target  :   self,
                          action  :   #selector(showMoviesAction)
        )
        
        let  tvShowsBtn =
        UIBarButtonItem ( title   :   "TV Shows",
                          style   :   .plain,
                          target  :   self,
                          action  :   #selector(showTVShowsAction)
        )
        let  logoBtn =
        UIBarButtonItem ( image   :   UIImage(named: S.picName.Logo),
                          style   :   .done,
                          target  :   nil,
                          action  :   nil
        )
        let checkBoxBtn =
        UIBarButtonItem ( title:     "Category",
                          style:     .plain,
                          target:    self,
                          action:    #selector(showCheckBoxView)
        )
        
        navigationItem.leftBarButtonItems = [
            logoBtn,
            moviesBtn,
            tvShowsBtn
        ]
        
        //SFsymbols
        navigationItem.rightBarButtonItems = [
            
            profileMangerBtn,
            checkBoxBtn
        ]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Color_Main")
        
        
    }
    
    @objc private func showMoviesAction() {
        showMovies = true
        showMoviesSubject.onNext(true)
    }
    
    @objc private func showTVShowsAction() {
        showMovies = false
        showMoviesSubject.onNext(false)
    }
    
    @objc private func handleLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func showCheckBoxView() {
        let genresListViewController = GenresListViewController()
        var genres: [Int16: String] = S.genresIndex.TV_genres
        
        if !showMovies{
            
            genres = S.genresIndex.TV_genres
        }
        
        else{
            genres = S.genresIndex.Movie_genres
        }
                
      
           
                      
        genresListViewController.delegate = self
        genresListViewController.genres = genres
        navigationController?.present(genresListViewController, animated: true)
    }
}
extension MainTabBarViewController: GenresListViewControllerDelegate {
    func selectedGenreDidChange(genre: Int16) {
        selectedGenre = genre
        selectedGenreSubject.onNext(genre)
    }
}
