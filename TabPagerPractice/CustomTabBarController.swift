//
//  CustomTabBarController.swift
//  TabPagerPractice
//
//  Created by 松尾淳平 on 2021/03/14.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var viewControllers = [UIViewController]()
        let first = ViewController()
        first.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let second = ViewController()
        second.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewControllers.append(first)
        viewControllers.append(second)
        self.viewControllers = viewControllers.map{ UINavigationController(rootViewController: $0)}
        self.setViewControllers(viewControllers, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
