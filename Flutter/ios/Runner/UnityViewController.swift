//
//  UnityViewController.swift
//  Runner
//
//  Created by Essi Jukkala on 10.11.2020.
//

import UIKit
import Flutter

class UnityViewController: UIViewController {
    private static weak var instance: UnityViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Unity View loaded!")
        
        UnityViewController.instance = self
    }
    
    static func startUnity(result: FlutterResult) {
        guard let sSelf = UnityViewController.instance else { fatalError("UnityViewController not found!") }
        
        let nativeWindow = UIApplication.shared.windows[0]
        
        UnityEmbeddedSwift.showUnity()
        
        var unityWindow: UIWindow?
        for window in UIApplication.shared.windows {
            if window != nativeWindow {
                unityWindow = window
            }
        }
        
        if let unityView = unityWindow {
            print("Set unity view")
            unityView.removeFromSuperview()
            unityView.frame = sSelf.view.bounds
            sSelf.view.insertSubview(unityView, at: 0)
            unityView.setNeedsLayout()
            nativeWindow.makeKeyAndVisible()
        }
        
        result("running")
    }
    
    static func stopUnity(result: FlutterResult) {
        guard let sSelf = UnityViewController.instance else { fatalError("UnityViewController not found!") }
        
        UnityEmbeddedSwift.unloadUnity()
        UnityEmbeddedSwift.hideUnity()
        
        for view in sSelf.view.subviews {
            view.removeFromSuperview()
        }
        
        sSelf.view.setNeedsLayout()
        
        result("none")
    }
}
