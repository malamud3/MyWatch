//
//  showTrailerViewController.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 13/12/2022.
//

import UIKit
import WebKit

class showTrailerViewController: UIViewController {
    
    private let showLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Name"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever!"
        return label
    }()
    
    private let dowmloadBtn: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(showLabel)
        view.addSubview(overviewLabel)
        view.addSubview(dowmloadBtn)
        
        configureConstraints()
        
        
    }
    

    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let showLabelConstraints = [
            showLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            showLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: showLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let dowmloadBtnConstraints = [
            dowmloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dowmloadBtn.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            dowmloadBtn.widthAnchor.constraint(equalToConstant: 140),
            dowmloadBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(showLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(dowmloadBtnConstraints)
        
    }
    
    
    func configure(with model: ShowTrailerViewModel) {
        //tasks that the user has initiated and requires immediate results
        DispatchQueue.global(qos: .userInitiated).async {
            // Perform network request on background thread
            guard let url = URL(string: "\(model.youtubeView.id.videoId)") else { return }
              let urlRequest  =  URLRequest(url: url)
            DispatchQueue.main.async {
                // Update UI on main thread
                self.showLabel.text = model.show
                self.overviewLabel.text = model.showOverview
                self.webView.load(urlRequest)
            }
        }
    }
    
    
}
