//
//  GenresCheckBoxView.swift
//  MyWatch
//
//  Created by Amir Malamud on 13/02/2023.
//

import UIKit

protocol GenresListViewControllerDelegate: AnyObject {
    func selectedGenresDidChange(genres: Set<Int16>)
}

class GenresListViewController: UIViewController {
    
    weak var delegate: GenresListViewControllerDelegate?

    let genres: [Int16: String] = S.genresIndex.genre
    
        var selectedGenres = Set<Int16>()

        lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(GenresTableViewCell.self, forCellReuseIdentifier: S.Identifier.GenreTableViewCell)
            return tableView
        }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let image = UIImage(systemName: "x.circle.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        view.addSubview(tableView)
        view.addSubview(closeButton)
        exitSetUP()

        }
    
   func exitSetUP(){
       
       //View - Constriants
       let closeButtonConstraints = [
           closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
       ]
       
       NSLayoutConstraint.activate(closeButtonConstraints)

       // Func
       closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
       
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }
    
    @objc private func closeButtonTapped() {
         delegate?.selectedGenresDidChange(genres: selectedGenres)
         dismiss(animated: true, completion: nil)
     }
}

    extension GenresListViewController: UITableViewDataSource , UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return genres.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: S.Identifier.GenreTableViewCell, for: indexPath) as? GenresTableViewCell else {
                return UITableViewCell()
            }
            let genre = Array(genres.values)[indexPath.row]
            cell.configure(with: genre)
           
            if selectedGenres.contains(Array(genres.keys)[indexPath.row]) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let genreKey = Array(genres.keys)[indexPath.row]
            if selectedGenres.contains(genreKey) {
                selectedGenres.remove(genreKey)
            } else {
                selectedGenres.insert(genreKey)
            }
            tableView.reloadData()
        }
    }
extension GenresListViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add fade effect to table view
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBackground.cgColor,UIColor.systemBackground.withAlphaComponent(0.75).cgColor]
                                
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.layer.mask = gradientLayer
    }
}
