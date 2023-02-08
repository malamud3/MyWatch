//
//  CollectionTableViewCell.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionTableViewCell , viewModel: ShowTrailerViewModel)
}

class CollectionTableViewCell: UITableViewCell {

    private var shows: [Show] = [Show]()

    weak var deleagte : CollectionViewTableViewCellDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: S.Identifier.ShowCollectionViewCell)
        
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
     public func congigure(with shows: [Show]){
         self.shows = shows;
         DispatchQueue.main.async { [weak self] in
             self?.collectionView.reloadData()
         }
    }
    
}




extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: S.Identifier.ShowCollectionViewCell, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = shows[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard collectionView == self.collectionView else { return }
        let theShow = shows[indexPath.row]
        guard let showName = theShow.original_title ?? theShow.original_name else { return }
        collectionView.isUserInteractionEnabled = false
        DispatchQueue.global().async {
            APICaller_Youtube.shared.getTrailer(for: showName + " trailer") { (videoURL) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                    {
                    if let videoURL = videoURL {
                        let videoElement = VideoElement(id: idVideoElement(kind: "", videoId: videoURL))
                        let viewModel = ShowTrailerViewModel(show: showName, youtubeView: videoElement, showOverview: theShow.overview!)
                        self.deleagte?.CollectionViewTableViewCellDidTapCell(self, viewModel: viewModel)
                    }
                }
            }
        }
        collectionView.isUserInteractionEnabled = true

    }
    
}
