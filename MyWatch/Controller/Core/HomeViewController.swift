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

    private var showMovies = true
    private let disposeBag = DisposeBag()
    
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
        
        configureHeaderView ()
        
        headerView = HeaderUiView(frame: CGRect(x: 0, y: -view.bounds.height - 10, width: view.bounds.width, height: view.bounds.height / 1.7))
        tableView.tableHeaderView = headerView
        
        modifyUI()
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
                    case false:
                        self?.apiCaller = APICaller_TV.shared
                    case .none:
                        self?.apiCaller = APICaller_Movie.shared
                    case .some(_):
                        break
                    }
                    self?.updateUI()
                }
            
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(){
        configureHeaderView()
        tableView.reloadData()
    }
    
    private func configureHeaderView () {
        
        apiCaller.getTrending { [weak self] result in
            switch result{
            case .success(let shows):
                let filteredShows = shows.filter { $0.poster_path != nil }
                let selectedShow = filteredShows.randomElement()
                self?.headerData = selectedShow
                self?.headerView?.configure(with: showViewModel(showName: selectedShow?.original_title ?? selectedShow?.original_name ?? "" , posterURL: selectedShow?.poster_path ?? "", dateRelece: ""))
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
    
    private func fetchData(for whatData: whatData, completion: @escaping (Result<[Show], Error>) -> Void) {
 
        
        switch whatData {
        case .Trending:
            apiCaller.getTrending(completion: completion)
        case .Popular:
            apiCaller.getPopular(completion: completion)
        case .RecentlyAdded:
           apiCaller.getRecentlyAdded(completion: completion)

        case .TopRated:
            apiCaller.getTopRated(completion: completion)
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
