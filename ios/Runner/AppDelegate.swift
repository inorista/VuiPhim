import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let brightnessChannel = FlutterMethodChannel(name: "native/brightness",
                                                     binaryMessenger: controller.binaryMessenger)

        let volumeChannel = FlutterMethodChannel(name: "native/volume", binaryMessenger: controller.binaryMessenger)
    
        volumeChannel.setMethodCallHandler {
            call, _ in
            // set volume
            if call.method == "setVoule" {}
        }
        
        brightnessChannel.setMethodCallHandler {
            call, result in
            if call.method == "setBrightness" {
                if let brightness = call.arguments as? Double {
                    self.setBrightness(brightness)
                    result(nil)
                    return
                }
            }
            if call.method == "getBrightness" {
                var brightness = self.getBrightness()
                result(brightness)
                return
            }
            result(FlutterMethodNotImplemented)
        }
    
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
//    private func setVolume(_ value: Double){
//        let volume = CGFloat(value)
//        UIDevice.
//    }
    
    private func setBrightness(_ value: Double) {
        let brightnessFLoat = CGFloat(value)
        UIScreen.main.brightness = brightnessFLoat
    }
    
    private func getBrightness() -> Double {
        return UIScreen.main.brightness
    }
    
    private func resetBrightness() {
        UIScreen.main.brightness = 1.0
    }
}
