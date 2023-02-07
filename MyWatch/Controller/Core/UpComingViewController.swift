//
//  Up_ComingViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit




class UpComingViewController: UIViewController {
    
    private var shows:[Movie] = [Movie]()

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
        
        fetchUpcoming()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming(){
        APICaller_Movie.shared.getUpcomingMovies{[weak self] result in
            switch result{
            case.success(let shows):
                self?.shows = shows
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: S.Identifier.ShowTableViewCell, for: indexPath) as? ShowTableViewCell else { return UITableViewCell() }
        
        let theShow = shows[indexPath.row]
        cell.configure(with: showViewModel(showName: theShow.original_title ?? theShow.original_name ?? "Unknown", posterURL: theShow.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
