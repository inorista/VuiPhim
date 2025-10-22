import Flutter
import UIKit

class BrightnessService {
    static let channelName = "native/brightness"
    private var channel: FlutterMethodChannel?

    func register(with messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(
            name: BrightnessService.channelName,
            binaryMessenger: messenger
        )

        channel?.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }

            switch call.method {
            case "setBrightness":
                if let args = call.arguments as? [String: Any],
                    let brightness = args["brightness"] as? Double
                {
                    self.setBrightness(brightness)
                    result(nil)
                } else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENT",
                            message: "Brightness value is missing or invalid",
                            details: nil
                        )
                    )
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
    }

    private func setBrightness(_ value: Double) {
        DispatchQueue.main.async {
            UIScreen.main.brightness = CGFloat(value)
        }
    }

    private func getBrightness() -> Double {
        return Double(UIScreen.main.brightness)
    }

    private func resetBrightness() {
        DispatchQueue.main.async {
            UIScreen.main.brightness = 1.0
        }
    }
}
