//
//  HomeViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit
import RxSwift


/* Sections to fetchData */
enum whatData: Int{
    case Trending = 0
    case Popular = 1
    case RecentlyAdded = 2
    case TopRated = 3
   
}

class HomeViewController: UIViewController {
    
    private var apiCaller  : APICaller_Show = APICaller_Movie.shared
    private var selectedGenre: Int16 = -1

    
    private var showMovies = true
    private var disposeBag = DisposeBag()
    
    private var headerData : Show?
    private var headerView : HeaderUiView?
    
    var sectionTitles: [String] = [S.HomeView_sectionTitles.Trending,S.HomeView_sectionTitles.Popular,S.HomeView_sectionTitles.RecentlyAdded,S.HomeView_sectionTitles.Top_Rated]
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: S.Identifier.CollectionViewTableViewCell)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureHeaderView(with: selectedGenre)
        
        headerView = HeaderUiView(frame: CGRect(x: 0, y: -view.bounds.height - 10, width: view.bounds.width, height: view.bounds.height / 1.7))
        tableView.tableHeaderView = headerView
        
        modifyUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }

    
    // Update the view based on the new value of showMovies
    private func modifyUI (){
        (self.tabBarController as? MainTabBarViewController)?.showMoviesSubject
            .subscribe(onNext: { [weak self] showMovies in
                if( self?.showMovies != showMovies){
              
                    self?.showMovies = showMovies
                    
                    switch self?.showMovies {
                    case true:
                        self?.apiCaller = APICaller_Movie.shared
                        self?.selectedGenre = -1
                    case false:
                        self?.apiCaller = APICaller_TV.shared
                        self?.selectedGenre = -1
                    case .none:
                        self?.apiCaller = APICaller_Movie.shared
                        self?.selectedGenre = -1
                    case .some(_):
                        break
                    }
                    self?.updateUI()
                }
            
            })
            .disposed(by: disposeBag)
        
        (self.tabBarController as? MainTabBarViewController)?.selectedGenreSubject
            .subscribe(onNext: { [weak self] genre in
                self?.selectedGenre = genre
                self?.updateUI()
            })
            .disposed(by: disposeBag)
        
        if let tabBarVC = tabBarController as? MainTabBarViewController {
            tabBarVC.isNavBarTranslucentSubject.onNext(true)
        }

    }
    
    private func updateUI(){
        configureHeaderView(with: selectedGenre)
        tableView.reloadData()
    }
    
    private func configureHeaderView(with selectedGenre: Int16, page: Int = 1) {
        apiCaller.getTrending(dataPage: page, Ganerfilter: selectedGenre) { [weak self] result in
            switch result{
            case .success(let shows):
                let filteredShows = shows.filter {
                    if $0.poster_path != nil {
                            return true
                    }
                    return false
                }
                if let selectedShow = filteredShows.randomElement() {
                    self?.headerData = selectedShow
                    self?.headerView?.configure(with: showViewModel(showName: selectedShow.original_title ?? selectedShow.title ?? "" , posterURL: selectedShow.poster_path ?? "", dateRelece: ""))
                } else {
                    // If no matching shows were found, increment the page number and try again
                    self?.configureHeaderView(with: selectedGenre, page: page + 1)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchData(for whatData: whatData, dataPage: Int = 1, completion: @escaping (Result<[Show], Error>) -> Void) {
            
            switch whatData {
            case .Trending:
                apiCaller.getTrending(dataPage: dataPage, Ganerfilter: selectedGenre) { result in
                    switch result {
                    case .success(let shows):
                        if shows.isEmpty {
                            self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                        }
                        completion(.success(shows))
                    case .failure(let error):
                        print(error.localizedDescription)
                        // If the API call failed, increment the data page and try again
                        self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                    }
                }
            case .Popular:
                apiCaller.getPopular(dataPage: dataPage, Ganerfilter: selectedGenre) { result in
                    switch result {
                    case .success(let shows):
                        if shows.isEmpty {
                            self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                        }
                        completion(.success(shows))
                    case .failure(let error):
                        print(error.localizedDescription)
                        // If the API call failed, increment the data page and try again
                        self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                    }
                }
            case .RecentlyAdded:
                apiCaller.getRecentlyAdded(dataPage: dataPage, Ganerfilter: selectedGenre) { result in
                    switch result {
                    case .success(let shows):
                        if shows.isEmpty {
                            self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                        }
                        completion(.success(shows))
                    case .failure(let error):
                        print(error.localizedDescription)
                        // If the API call failed, increment the data page and try again
                        self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                    }
                }
            case .TopRated:
                apiCaller.getTopRated(dataPage: dataPage, Ganerfilter: selectedGenre) { result in
                    switch result {
                    case .success(let shows):
                        if shows.isEmpty {
                            self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                        }
                        completion(.success(shows))
                    case .failure(let error):
                        print(error.localizedDescription)
                        // If the API call failed, increment the data page and try again
                        self.fetchData(for: whatData, dataPage: dataPage + 1, completion: completion)
                    }
                }
            }
        }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: S.Identifier.CollectionViewTableViewCell, for: indexPath) as? CollectionTableViewCell else{
            return UITableViewCell()
        }
        
        cell.deleagte = self
        
        fetchData(for: whatData(rawValue: indexPath.section) ?? whatData.Popular) { result in
            switch result {
            case .success(let shows):
                let fixShows = shows.filter { show in
                    return show.poster_path != nil
                }
                cell.congigure(with: fixShows)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    // font for shows
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
          guard let header = view as? UITableViewHeaderFooterView else {return}
          header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
          header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
          header.textLabel?.textColor = .white
          header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
      }
    
    
    // Effect for Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))


            for cell in tableView.visibleCells {
                if let collectionCell = cell as? CollectionTableViewCell {
                    if collectionCell.hasReachedEnd {
                        print(collectionCell.hasReachedEnd)
                }
            }
        }
    }
    
    
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: ShowTrailerViewModel) {
        let vc = showTrailerViewController()
        vc.configure(with: viewModel)
        
            if self.navigationController?.viewControllers.contains(vc) == false {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    
}

