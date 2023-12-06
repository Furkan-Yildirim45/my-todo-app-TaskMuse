
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager{
  static final FlutterLocalNotificationsPlugin _notificationHelper = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async{
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await _notificationHelper.initialize(initializationSettings);
  }

  static Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails("channelId", "channelName",importance: Importance.max)
    );
  }
  static Future showNotification({int id = 0,required String title,required String body,required String payload}) async =>
      _notificationHelper.show(id, title, body, await notificationDetails(),payload: payload);

  static Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDateTime,
  }) async =>
      _notificationHelper.zonedSchedule(
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        id, title, body, tz.TZDateTime.from(scheduledDateTime, tz.local),
        await notificationDetails(), uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,);

  static Future unScheduleAllNotification() async => await _notificationHelper.cancelAll();
}

