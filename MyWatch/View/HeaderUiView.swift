//
//  HeaderUiView.swift
//  GamesStore_UIKit
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit

class HeaderUiView: UIView {
    
    //Buttons
    private let btn_addToList: UIButton = {
            let btn = UIButton()
            let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setImage(image, for: .normal)
        
            return btn
        }()
    
    private let btn_play: UIButton = {
        
        let button = UIButton()
        button.setTitle(S.ButtonName.btn_play_title, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    private let imageView_header: UIImageView = {
            let imageView = UIImageView ()
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "")
            return imageView
        
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    // fade effect
    private func addGradient(){
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.systemBackground.cgColor
            ]
        gradientLayer.frame = bounds
            containerView.layer.addSublayer(gradientLayer)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)

        containerView.addSubview(imageView_header)
        containerView.addSubview(btn_play)
        containerView.addSubview(btn_addToList)
        
        addGradient()
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }

    
    // constrains
    private func applyConstraints() {
        
        let playButtonConstraints = [
            btn_play.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            btn_play.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            btn_play.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let addToListButtonConstraints = [
            btn_addToList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            btn_addToList.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            btn_addToList.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(addToListButtonConstraints)
    }
    

    public func configure(with model: showViewModel){
        guard let url = URL(string: "\(S.API_TV.imgURL)\(model.posterURL)") else { return}
           
        imageView_header.sd_setImage(with: url, completed: nil)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = CGRect(x: 8, y: 8, width: self.bounds.width - 16, height: self.bounds.height - 16)
        imageView_header.frame = containerView.bounds
    }

}
