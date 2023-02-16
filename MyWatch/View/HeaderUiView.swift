//
//  HeaderUiView.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//

import UIKit

class HeaderUiView: UIView {
    
    //Buttons
    private let btn_addToList: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, for: .normal)
            button.tintColor = UIColor.white

            return button
        }()
    
    
    private let btn_info: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, for: .normal)
            button.tintColor = UIColor.white

            return button
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
            imageView.sizeToFit()
            return imageView
        
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.contentMode = .scaleToFill

        return view
    }()
    
    
    // fade effect
    private func addGradient(){
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor,
                                    UIColor.systemBackground.withAlphaComponent(0.79).cgColor]
            gradientLayer.frame = bounds
            containerView.layer.addSublayer(gradientLayer)
            
            addSubview(btn_play)
            addSubview(btn_addToList)
            addSubview(btn_info)

    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containerView)

        containerView.addSubview(imageView_header)
        addSubview(btn_play)
        addSubview(btn_addToList)
        addSubview(btn_info)

        
        addGradient()
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }

    
    // constrains
    private func applyConstraints() {
        
   
        let btnInfoConstraints = [
            btn_info.trailingAnchor.constraint(equalTo: btn_play.leadingAnchor, constant: -30),
            btn_info.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ]
        
        
        let playButtonConstraints = [
            btn_play.centerXAnchor.constraint(equalTo: centerXAnchor),
            btn_play.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            btn_play.heightAnchor.constraint(equalToConstant: 20),
            btn_play.widthAnchor.constraint(equalToConstant: 100)

        ]
        
        
        let addToListButtonConstraints = [
            
            btn_addToList.leadingAnchor.constraint(equalTo: btn_play.trailingAnchor, constant: 30),
            btn_addToList.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            
        ]
        
 
        NSLayoutConstraint.activate(btnInfoConstraints)
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
