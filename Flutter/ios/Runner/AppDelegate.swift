import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        UnityEmbeddedSwift.setLaunchinOptions(launchOptions)
        UnityEmbeddedSwift.setHostMainWindow(window)
        
        GeneratedPluginRegistrant.register(with: self)

        weak var registrar = self.registrar(forPlugin: "plugin-name")
        
        let unityChannel = FlutterMethodChannel(name: "testing.ios.native/unity", binaryMessenger: registrar!.messenger())
        
        unityChannel.setMethodCallHandler { (call, result) in
            if call.method == "startUnity" {
                UnityViewController.startUnity(result: result)
            }
            
            if call.method == "stopUnity" {
                UnityViewController.stopUnity(result: result)
            }
        }

        let factory = FLNativeViewFactory(messenger: registrar?.messenger())
        self.registrar(forPlugin: "<plugin-name>")?.register(
            factory,
            withId: "<platform-view-type>")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
