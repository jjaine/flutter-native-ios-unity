//
//  FLNativeViewFactory.swift
//  Runner
//
//  Created by Essi Jukkala on 9.11.2020.
//

import UIKit
import Flutter

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var messenger: FlutterBinaryMessenger?
    
    init(messenger: FlutterBinaryMessenger?) {
        super.init()
        self.messenger = messenger
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
}
