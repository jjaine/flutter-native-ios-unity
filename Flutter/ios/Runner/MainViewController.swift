//
//  MainViewController.swift
//  Runner
//
//  Created by Essi Jukkala on 9.11.2020.
//

import UIKit
import UnityFramework

class MainViewController: UITabBarController, UITabBarControllerDelegate  {
    var unityNC: UINavigationController?
    var nativeNC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main View loaded!")
        
        delegate = self

        // start unity and immediatly set as rootViewController
        // this loophole makes it possible to run unity in the same window
        UnityEmbeddedSwift.showUnity()
        let unityViewController = UnityEmbeddedSwift.getUnityRootViewController()!
        unityViewController.navigationItem.title = "Unity"

        unityNC = UINavigationController.init(rootViewController: unityViewController)
        unityNC?.tabBarItem.title = "Unity"

        let nativeViewController = UIViewController.init()
        nativeViewController.view.backgroundColor = UIColor.darkGray
        nativeViewController.navigationItem.title = "Native"

        nativeNC = UINavigationController.init(rootViewController: nativeViewController)
        nativeNC?.tabBarItem.title = "Native"

        viewControllers = [unityNC!, nativeNC!]

        // select other tab and reselect first tab to unfreeze unity-loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.selectedIndex = 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.selectedIndex = 0
            })
        })
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // pause unity if unity-tab is not selected
        if viewController != unityNC {
            UnityEmbeddedSwift.pauseUnity()
        } else {
            UnityEmbeddedSwift.unpauseUnity()
        }
    }

}
