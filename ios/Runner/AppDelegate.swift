import Flutter
import UIKit
import AudioToolbox

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let brightnessChannel = FlutterMethodChannel(name: "native/brightness",
                                                     binaryMessenger: controller.binaryMessenger)
        let vibrationChannel = FlutterMethodChannel(name: "native/vibration",
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
        
        vibrationChannel.setMethodCallHandler {
            [weak self] call, result in
            guard let self = self else {
                result(FlutterError(code: "UNAVAILABLE", message: "AppDelegate is nil", details: nil))
                return
            }
            
            switch call.method {
            case "vibrate":
                // Vibrate với kiểu mặc định
                self.vibrate()
                result(nil)
                
            case "vibrateWithIntensity":
                if let args = call.arguments as? [String: Any],
                   let intensity = args["intensity"] as? Int
                {
                    self.vibrateWithIntensity(intensity)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Intensity value is missing or invalid", details: nil))
                }
                
            case "impactFeedback":
                if let args = call.arguments as? [String: Any],
                   let style = args["style"] as? String
                {
                    self.impactFeedback(style: style)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Style value is missing or invalid", details: nil))
                }
                
            case "selectionFeedback":
                self.selectionFeedback()
                result(nil)
                
            case "notificationFeedback":
                if let args = call.arguments as? [String: Any],
                   let type = args["type"] as? String
                {
                    self.notificationFeedback(type: type)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Type value is missing or invalid", details: nil))
                }
                
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
    
    // MARK: - Vibration Methods
    
    private func vibrate() {
        // Kiểm tra nếu thiết bị hỗ trợ vibration
        if UIDevice.current.model != "iPhone Simulator" {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    private func vibrateWithIntensity(_ intensity: Int) {
        // iOS không hỗ trợ intensity trực tiếp, nhưng ta có thể mô phỏng
        switch intensity {
        case 0: // Light
            // Không rung cho intensity nhẹ nhất
            break
        case 1: // Medium
            // Rung nhẹ
            AudioServicesPlaySystemSound(SystemSoundID(1519)) // Peek feedback
        case 2: // Heavy
            // Rung mạnh
            AudioServicesPlaySystemSound(SystemSoundID(1520)) // Pop feedback
        default:
            // Mặc định
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    private func impactFeedback(style: String) {
        var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
        
        switch style.lowercased() {
        case "light":
            feedbackStyle = .light
        case "medium":
            feedbackStyle = .medium
        case "heavy":
            feedbackStyle = .heavy
        case "soft":
            if #available(iOS 13.0, *) {
                feedbackStyle = .soft
            } else {
                feedbackStyle = .light
            }
        case "rigid":
            if #available(iOS 13.0, *) {
                feedbackStyle = .rigid
            } else {
                feedbackStyle = .heavy
            }
        default:
            feedbackStyle = .medium
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: feedbackStyle)
        impactFeedback.impactOccurred()
    }
    
    private func selectionFeedback() {
        let selectionFeedback = UISelectionFeedbackGenerator()
        selectionFeedback.selectionChanged()
    }
    
    private func notificationFeedback(type: String) {
        var feedbackType: UINotificationFeedbackGenerator.FeedbackType
        
        switch type.lowercased() {
        case "success":
            feedbackType = .success
        case "warning":
            feedbackType = .warning
        case "error":
            feedbackType = .error
        default:
            feedbackType = .success
        }
        
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(feedbackType)
    }
}
