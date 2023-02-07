//
//  CollectionViewCell_Show.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 05/12/2022.
//

import UIKit
import SDWebImage

class ShowCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = CGRect(x: 8, y: 8, width: contentView.bounds.width - 16, height: contentView.bounds.height - 16)
        posterImageView.frame =  containerView.bounds
    }
    
    public func configure(with model: String){
        guard let url = URL(string: "\(S.API_TV.imgURL)\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
        
        animateIn()
    }
    
    func animateIn() {
        containerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        containerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.containerView.transform = .identity
            self.containerView.alpha = 1
        }, completion: nil)
    }
}

