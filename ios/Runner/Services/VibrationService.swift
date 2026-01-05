import AudioToolbox
import Flutter
import UIKit

class VibrationService {
    static let channelName = "native/vibration"
    private var channel: FlutterMethodChannel?

    func register(with messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(
            name: VibrationService.channelName,
            binaryMessenger: messenger
        )

        channel?.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }

            switch call.method {
            case "vibrate":
                self.vibrate()
                result(nil)

            case "vibrateWithIntensity":
                if let args = call.arguments as? [String: Any],
                    let intensity = args["intensity"] as? Int
                {
                    self.vibrateWithIntensity(intensity)
                    result(nil)
                } else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENT",
                            message: "Intensity value is missing or invalid",
                            details: nil
                        )
                    )
                }

            case "impactFeedback":
                if let args = call.arguments as? [String: Any],
                    let style = args["style"] as? String
                {
                    self.impactFeedback(style: style)
                    result(nil)
                } else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENT",
                            message: "Style value is missing or invalid",
                            details: nil
                        )
                    )
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
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENT",
                            message: "Type value is missing or invalid",
                            details: nil
                        )
                    )
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func vibrate() {
        if UIDevice.current.model != "iPhone Simulator" {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    private func vibrateWithIntensity(_ intensity: Int) {
        switch intensity {
        case 0:
            break
        case 1:
            AudioServicesPlaySystemSound(SystemSoundID(1519))
        case 2:
            AudioServicesPlaySystemSound(SystemSoundID(1520))
        default:
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
