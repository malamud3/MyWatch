//
//  SearchViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController  {
    
    private var apiCaller  : APICaller_Show = APICaller_Movie.shared

    private var shows:[Show] = [Show]()

    private var showMovies  = true
    private let disposeBag = DisposeBag()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(ShowTableViewCell.self, forCellReuseIdentifier: S.Identifier.ShowTableViewCell)
        return table
    }()
    
    private let searchController: UISearchController = {
       
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = S.SearchStrings.searchPlaceHolder
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = S.title.search
        view.backgroundColor = .systemBackground;
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        
        navigationItem.searchController = searchController
        
        
        fetchData ()
        
        searchController.searchResultsUpdater = self
        
        
        modifyUIMovieOrTvShow ()
    }
    
    // Update the view based on the new value of showMovies
    private func modifyUIMovieOrTvShow (){
        (self.tabBarController as? MainTabBarViewController)?.showMoviesSubject
            .subscribe(onNext: { [weak self] showMovies in
                
                self?.showMovies = showMovies
                switch self?.showMovies {
                case true:
                    self?.apiCaller = APICaller_Movie.shared
                case false:
                    self?.apiCaller = APICaller_TV.shared
                case .none:
                    self?.apiCaller = APICaller_Movie.shared
                case .some(_):
                    break
                }
                self?.fetchData()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchData () {
        apiCaller.getPopular { [weak self] result in
            switch result {
            case .success(let shows):
                self?.shows = shows.filter { show in
                    return show.poster_path != nil
                }
                
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: S.Identifier.ShowTableViewCell, for: indexPath) as? ShowTableViewCell else {return UITableViewCell()}
        
        let theShow = shows[indexPath.row]
        
        let model = showViewModel(showName: theShow.original_title ?? theShow.original_name ?? "Unknown", posterURL: theShow.poster_path ?? "",dateRelece: "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        guard let query = searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty,
            query.trimmingCharacters(in: .whitespaces).count >= 1,
            let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                return 
        }
        
        resultsController.delegate = self
        
        
        APICaller_Movie.shared.doSearch(with: query) {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    resultsController.shows = shows
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsViewControllerDidTapItem(viewModel: ShowTrailerViewModel) {
           DispatchQueue.main.async { [weak self] in
               let vc = showTrailerViewController()
               vc.configure(with: viewModel)
                   self?.navigationController?.pushViewController(vc, animated: true)
           }
       }
}
