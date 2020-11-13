//
//  FLNativeView.swift
//  Runner
//
//  Created by Essi Jukkala on 9.11.2020.
//

import UIKit
import Flutter

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        _view = UIView(frame: frame)
        _view.backgroundColor = .systemGreen
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController,
           let mainViewController = rootViewController.storyboard?.instantiateViewController(identifier: "UnityViewController") {
            rootViewController.addChild(mainViewController)
            _view.addSubview(mainViewController.view)
            
            mainViewController.didMove(toParent: rootViewController)
            
            mainViewController.view.frame = frame
        }
        
        super.init()
    }

    func view() -> UIView {
        
        
        return _view
    }
    
    
}
