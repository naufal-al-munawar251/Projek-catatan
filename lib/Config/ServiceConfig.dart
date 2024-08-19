import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = 'my_foreground';
const notificationId = 888;

void startService() {
  final service = FlutterBackgroundService();

  // Configure Android Notification Channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'MY FOREGROUND SERVICE', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      foregroundServiceNotificationId: notificationId,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

void onStart(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    // Set as foreground service
    service.setAsForegroundService();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    // Show notification periodically
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          notificationId,
          'Catatan',
          'Aplikasi berjalan dilatar belakang',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              'MY FOREGROUND SERVICE',
              icon: '@mipmap/ic_launcher',
              ongoing: true, // Keeps the notification active
              onlyAlertOnce: true, // Only alerts the user the first time
            ),
          ),
        );

      }
    });
  }

  // Listen for stop service events
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Send update to the service
  service.invoke('update', {"value": "Service is running"});
}

bool onIosBackground(ServiceInstance service) {
  // Handle background tasks on iOS
  return true;
}
