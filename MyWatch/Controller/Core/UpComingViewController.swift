//
//  Up_ComingViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit
import RxSwift



class UpComingViewController: UIViewController {
    
    private var apiCaller  : APICaller_Show = APICaller_Movie.shared
    private var selectedGenre: Int16 = -1

    
    private var shows:[upComingShow] = [upComingShow]()

    private var showMovies  = true
    private let disposeBag = DisposeBag()
    
    private var myPage = 1
    
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(ShowTableViewCell.self, forCellReuseIdentifier: S.Identifier.ShowTableViewCell)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = S.title.upcoming
        view.backgroundColor = .systemBackground;
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
            upcomingTable.delegate = self
            upcomingTable.dataSource = self
        
        fetchData()
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
        upcomingTable.frame = view.bounds
    }
    
    private func fetchData(){
        
        apiCaller.getUpcoming(dataPage: myPage, Ganerfilter: selectedGenre){ [weak self] result in
            switch result{
            case.success(let shows):
                
                self?.shows = self?.filterShows(shows) ?? shows
           
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func filterShows(_ shows: [upComingShow]) -> [upComingShow] {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let sortedShows = shows.sorted { (show1, show2) -> Bool in
            guard let date1 = show1.first_air_date, let date2 = show2.first_air_date,
                  let show1Date = dateFormatter.date(from: date1),
                  let show2Date = dateFormatter.date(from: date2) else {
                return false
            }
            return show1Date < show2Date
        }
        let filteredShows = sortedShows.filter { (show) -> Bool in
               guard let date = show.first_air_date,
                     let showDate = dateFormatter.date(from: date),
                     let posterPath = show.poster_path else {
                   return false
               }
               return showDate >= currentDate && !posterPath.isEmpty
           }
           return filteredShows
       }
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: S.Identifier.ShowTableViewCell, for: indexPath) as? ShowTableViewCell else { return UITableViewCell() }
        
        let theShow = shows[indexPath.row]
        cell.configure(with: showViewModel(showName: theShow.name  ?? "Unknown", posterURL: theShow.poster_path ?? "",dateRelece: theShow.first_air_date?.fixFormatDate() ?? "Unknown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let lastItem = shows.count - 1
         myPage+=1
         if indexPath.row == lastItem {
             // make API call to get more data
             apiCaller.getUpcoming(dataPage: myPage, Ganerfilter: -1){ [weak self] result in
                 switch result {
                 case .success(let shows):
                     if shows.count == 0 {
                                          return
                    }
                     self?.shows += self?.filterShows(shows) ?? shows
                     DispatchQueue.main.async {
                         self?.upcomingTable.reloadData()
                     }
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
         }
     }

}
