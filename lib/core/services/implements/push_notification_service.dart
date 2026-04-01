import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/services/interfaces/ilocal_notification_service.dart';
import 'package:vuiphim/core/services/interfaces/ipush_notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

@LazySingleton(as: IPushNotificationService)
class PushNotificationService implements IPushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final ILocalNotificationService _localNotificationService;

  PushNotificationService(this._localNotificationService);

  @override
  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (Platform.isIOS || Platform.isMacOS) {
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    log('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        if (Platform.isAndroid) {
          try {
            _localNotificationService.showNotification(
              id: message.messageId.hashCode,
              title: message.notification?.title ?? '',
              body: message.notification?.body ?? '',
              payload: message.data.toString(),
            );
            log('Local notification displayed successfully for Android.');
          } catch (e, stack) {
            log(
              'Failed to show local notification: $e\n$stack',
              error: e,
              stackTrace: stack,
            );
          }
        } else {
          log(
            'Skipping local notification on iOS because setForegroundNotificationPresentationOptions handles it natively.',
          );
        }
      }
    });

    if (Platform.isIOS || Platform.isMacOS) {
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      log('APNS Token: $apnsToken');
      if (apnsToken != null) {
        final fcmToken = await _firebaseMessaging.getToken();
        log("FCM Token (iOS): $fcmToken");
      }
    } else {
      final fcmToken = await _firebaseMessaging.getToken();
      log("FCM Token (Android): $fcmToken");
    }

    _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      log("FCM Token Refreshed: $fcmToken");
    });
  }
}
