import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService _instance = LocalNotificationService._();
  factory LocalNotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'forgot_password_channel',
        'Forgot Password',
        description: 'Notifications for forgot password flow',
        importance: Importance.max,
      );
      await androidPlugin.createNotificationChannel(channel);
    }
    
    _isInitialized = true;
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'forgot_password_channel',
      'Forgot Password',
      channelDescription: 'Notifications for forgot password flow',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
