import '../Constants/export.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    try {
      AndroidInitializationSettings initializationSettingsAndroid =
          const AndroidInitializationSettings('mipmap/ic_launcher');
      
      var initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);

      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      
      await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
          // Handle notification tap
          debugPrint('Notification tapped: ${notificationResponse.payload}');
        },
      );
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }

  Future<NotificationDetails> notificationDetails() async {
    try {
      return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );
    } catch (e) {
      debugPrint('Error creating notification details: $e');
      rethrow;
    }
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    try {
      final details = await notificationDetails();
      await notificationsPlugin.show(id, title, body, details);
    } catch (e) {
      debugPrint('Error showing notification: $e');
      // Don't rethrow the error to prevent app crashes
    }
  }
}
