import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    setupMethodChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    private func setupMethodChannel() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "myappetizeintent", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getIsAppetizeIntent" {
                    // Implement the code to retrieve the boolean value from iOS here
                let isAppetizeIntent = UserDefaults.standard.bool(forKey: "isAppetize")
                result(isAppetizeIntent)
            } else {
                result(false)
            }
        })
    }
}
