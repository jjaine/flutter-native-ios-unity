//
//  FLPlugin.swift
//  Runner
//
//  Created by Essi Jukkala on 9.11.2020.
//

import UIKit
import Flutter

class FLPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "<platform-view-type>")
    }
}
