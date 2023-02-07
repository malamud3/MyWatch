//
//  SerchResultsViewController.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 12/12/2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(viewModel: ShowTrailerViewModel)
}



class SearchResultsViewController: UIViewController {
    
    //SearchViewController need acsses => Public
    var shows:[Movie] = [Movie]()

    public weak var delegate: SearchResultsViewControllerDelegate?

    let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 2 - 10)
        layout.minimumInteritemSpacing =  0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: S.Identifier.ShowCollectionViewCell)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
        
    } 
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: S.Identifier.ShowCollectionViewCell, for: indexPath) as? ShowCollectionViewCell else{ return UICollectionViewCell() }
        
        guard let model = shows[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let theShow = shows[indexPath.row]
        guard let showName = theShow.original_title ?? theShow.original_name else { return }
        collectionView.isUserInteractionEnabled = false
        DispatchQueue.global().async {
            APICaller_Youtube.shared.getTrailer(for: showName + " trailer") { (videoURL) in
                DispatchQueue.main.async {
                    if let videoURL = videoURL {
                        let videoElement = VideoElement(id: idVideoElement(kind: "", videoId: videoURL))
                        let viewModel = ShowTrailerViewModel(show: showName, youtubeView: videoElement, showOverview: theShow.overview!)
                        self.delegate?.searchResultsViewControllerDidTapItem(viewModel: viewModel)
                    }
                }
            }
        }
        collectionView.isUserInteractionEnabled = true

    }
    
}
