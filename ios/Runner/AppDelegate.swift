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

        brightnessChannel.setMethodCallHandler {
            [weak self] call, result in
            guard let self = self else {
                result(FlutterError(code: "UNAVAILABLE", message: "AppDelegate is nil", details: nil))
                return
            }
            
            switch call.method {
            case "setBrightness":
                if let args = call.arguments as? [String: Any],
                   let brightness = args["brightness"] as? Double
                {
                    self.setBrightness(brightness)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Brightness value is missing or invalid", details: nil))
                }
                
            case "getBrightness":
                let brightness = self.getBrightness()
                result(brightness)
                
            case "resetBrightness":
                self.resetBrightness()
                result(nil)
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setBrightness(_ value: Double) {
        let brightnessFloat = CGFloat(value)
        UIScreen.main.brightness = brightnessFloat
    }
    
    private func getBrightness() -> Double {
        return Double(UIScreen.main.brightness)
    }
    
    private func resetBrightness() {
        UIScreen.main.brightness = 1.0
    }
}
