//
//  InstagramSharingService.swift
//  Runner
//
//  Created by Tu on 22/10/25.
//

import Flutter
import UIKit

class InstagramSharingService {
    static let channelName = "native/instagramSharing"
    private var channel: FlutterMethodChannel?

    func register(with messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(
            name: InstagramSharingService.channelName,
            binaryMessenger: messenger
        )

        channel?.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }

            switch call.method {
                
            case "instagramShareSticker":
                self.handleShareSticker(call: call, result: result)
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func handleShareSticker(
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        let kInstagramAppId = "643432537207226"
        
        guard let args = call.arguments as? [String: Any] else {
            result(
                FlutterError(
                    code: "INVALID_ARGS",
                    message: "Arguments không hợp lệ",
                    details: nil
                )
            )
            return
        }

        var pasteboardItems: [String: Any] = [:]

        guard
            let stickerDataTyped = args["stickerImage"]
                as? FlutterStandardTypedData
        else {
            result(
                FlutterError(
                    code: "INVALID_STICKER",
                    message: "Không tìm thấy stickerImage hoặc sai định dạng",
                    details: nil
                )
            )
            return
        }

        let stickerData = stickerDataTyped.data
        guard let stickerImage = UIImage(data: stickerData) else {
            result(
                FlutterError(
                    code: "IMAGE_CONVERSION_FAILED",
                    message:
                        "Không thể chuyển đổi dữ liệu sticker thành UIImage",
                    details: nil
                )
            )
            return
        }
        pasteboardItems["com.instagram.sharedSticker.stickerImage"] =
            stickerImage

        if let backgroundDataTyped = args["backgroundImage"]
            as? FlutterStandardTypedData
        {
            let backgroundData = backgroundDataTyped.data
            if let backgroundImage = UIImage(data: backgroundData) {
                pasteboardItems["com.instagram.sharedSticker.backgroundImage"] =
                    backgroundImage
            }
        }

        guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(kInstagramAppId)") else {
            result(
                FlutterError(
                    code: "URL_ERROR",
                    message: "URL scheme không hợp lệ",
                    details: nil
                )
            )
            return
        }

        if UIApplication.shared.canOpenURL(urlScheme) {
            UIPasteboard.general.setItems([pasteboardItems])

            UIApplication.shared.open(
                urlScheme,
                options: [:],
                completionHandler: nil
            )

            result(nil)
        } else {
            result(
                FlutterError(
                    code: "APP_NOT_FOUND",
                    message: "Không tìm thấy Instagram",
                    details: nil
                )
            )
        }
    }
}
