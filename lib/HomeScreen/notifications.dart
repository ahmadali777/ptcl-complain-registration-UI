import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Initialize the notification plugin globally
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Global list to store notifications
final List<Map<String, String>> notifications = [];

/// Initialize notifications for the app
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create notification channel (recommended for Android 8.0+)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'complaint_channel', // Consistent with notification details
    'Complaint Notifications',
    description: 'Channel for complaint-related notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

/// Function to show an instant notification and add it to the notification list
Future<void> showNotification({
  required int id,
  required String title,
  required String body,
}) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'complaint_channel', // Match with channel creation
    'Complaint Notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  // Show the notification
  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    notificationDetails,
  );

  // Add the notification to the list
  notifications.add({'title': title, 'body': body});
}

/// Request notification permissions
Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied ||
      await Permission.notification.isPermanentlyDenied) {
    await Permission.notification.request();
  }
}
