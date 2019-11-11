//
//  MainTabVC.swift
//  FirebaseLesson2Iram
//
//  Created by C4Q on 11/11/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {

    let postsVC = PostsVC()
    let createVC = CreatePostVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        createVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        self.viewControllers = [postsVC, createVC]
        
    }
    

    

}
