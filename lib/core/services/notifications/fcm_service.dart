import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FcmService {
  FcmService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _requestPermission();
    
    final token = await _getToken();
    if (token != null) {
      await _saveTokenToFirestore(token);
    }

    await _initLocalNotifications();
    _listenToForegroundMessages();
    _listenToBackgroundMessages();
    _handleTerminatedStateMessages();
  }

  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        log('Notification Permission: Authorized');
        break;
      case AuthorizationStatus.provisional:
        log('Notification Permission: Provisional');
        break;
      case AuthorizationStatus.denied:
        log('Notification Permission: Denied');
        break;
      case AuthorizationStatus.notDetermined:
        log('Notification Permission: Not Determined');
        break;
    }
  }

  static Future<String?> _getToken() async {
    try {
      final token = await _messaging.getToken();
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  static Future<void> _saveTokenToFirestore(String token) async {
    try {
      await FirebaseFirestore.instance.collection('user_tokens').doc(token).set({
        'token': token,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': 'android',
      });
      log('FCM Token successfully saved to Firestore');
    } catch (e) {
      log('Error saving token to Firestore: $e');
    }
  }


  static Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


  static void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('FCM: Received message in foreground');
      _showLocalNotification(message);
    });
  }


  static void _listenToBackgroundMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('FCM: App opened from background via notification');
      _handleMessageAction(message);
    });
  }


  static void _handleTerminatedStateMessages() {
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        log('FCM: App opened from terminated state via notification');
        _handleMessageAction(message);
      }
    });
  }


  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(
              notification.body ?? '',
              contentTitle: notification.title,
              summaryText: notification.body,
            ),
            icon: android.smallIcon,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    log('FCM: Local notification tapped with payload: ${response.payload}');
  }

  static void _handleMessageAction(RemoteMessage message) {
    log('FCM: Handling action for message: ${message.messageId}');
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log('FCM: Handling a background message: ${message.messageId}');
  }
}
