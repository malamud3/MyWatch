//
//  ViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 10/11/2022.
//


import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavbar()
        navigationController?.isNavigationBarHidden = false

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpComingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: MyListViewController())

        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        
        
        // use this to make the icons bold when they are selected
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "play.circle.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.clipboard.fill")
        
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "My List"
        
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
   // NAV -> Porfile, LOGO-> FirstPage
    
    private func configureNavbar(){
        
        let image = UIImage(named: S.picName.Logo)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        //SFsymbols
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style:.done, target: self, action: #selector(handleLogin)),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style:.done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Color_Main")
    }
    
    
    
    
    
    
    @objc private func handleLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)

    }
    
    
}
