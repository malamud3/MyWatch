//
//  GenresTableViewCell.swift
//  MyWatch
//
//  Created by Amir Malamud on 16/02/2023.
//

import UIKit

class GenresTableViewCell: UITableViewCell {
    

    //Label
    private let genreLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(genreLabel)
        applyConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
   // init fail
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Constraints
    private func applyConstraints() {

            let genreLabelConstraints = [
                genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                genreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)            ]
            
            NSLayoutConstraint.activate(genreLabelConstraints)
        }
    
    // set Data for UI cell
    public func configure(with genre: String){
        
        genreLabel.text = genre
        
    }
   
}
