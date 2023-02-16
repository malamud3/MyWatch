//
//  ShowTableViewCell.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/12/2022.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    //btn
    private let btn_addToList: UIButton = {
        
        let btn = UIButton()
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    //Label
    private let showLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    //Label
    private let dateLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    // Image
    private let showPosterUIImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private let containerView: UIView = {
            let view = UIView()
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 10
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            view.backgroundColor = .systemGray6
            return view
        }()
    
    //init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        
        contentView.addSubview(containerView)
        contentView.addSubview(showPosterUIImageView)
        contentView.addSubview(showLabel)
        contentView.addSubview(btn_addToList)
        contentView.addSubview(dateLabel)

        applyConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = CGRect(x: 8, y: 8, width: contentView.bounds.width - 16, height: contentView.bounds.height - 16)
        showPosterUIImageView.frame =  containerView.bounds
    }
    
   // init fail
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Constraints
    private func applyConstraints() {
            
            // Poster image
            let showPosterUIImageViewConstraints = [
                showPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                showPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                showPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
                showPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)

            ]

            // Show Label
            let showLabelConstraints = [
                showLabel.leadingAnchor.constraint(equalTo: showPosterUIImageView.trailingAnchor, constant: 5),
                showLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                showLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ]
            
            // Date Label
            let dateLabelConstraints = [
                dateLabel.leadingAnchor.constraint(equalTo: showPosterUIImageView.trailingAnchor, constant: 5),
                dateLabel.topAnchor.constraint(equalTo: showLabel.bottomAnchor ,constant: 10),
                dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ]
            
            // Add to List Button
            let btn_addToListConstraints = [
                btn_addToList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                btn_addToList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            ]
            
            NSLayoutConstraint.activate(showPosterUIImageViewConstraints)
            NSLayoutConstraint.activate(showLabelConstraints)
            NSLayoutConstraint.activate(dateLabelConstraints)
            NSLayoutConstraint.activate(btn_addToListConstraints)
        }
    
    // set Data for UI cell
    public func configure(with model: showViewModel){
        
        guard let url = URL(string: "\(S.API_TV.imgURL)\( model.posterURL)") else {return}
                showPosterUIImageView.sd_setImage(with: url , completed: nil) // get show image
                showLabel.text = model.showName                               // get show name
                dateLabel.text = model.dateRelece
        
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
