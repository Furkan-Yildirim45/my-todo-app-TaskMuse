import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduledOrNowNotificationTrigger{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  ScheduledOrNowNotificationTrigger(this._flutterLocalNotificationsPlugin);

  Future<void> showNotification({String? title, String? content}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'id_1',
      'name_1',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      1,
      title ?? 'Notification Title',
      content ?? 'Notification Content',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> scheduleNotification(
      {String? title, String? content,int? hour, int? min, int? second}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id_1',
      'name_2',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Şu anki zaman
    final DateTime now = DateTime.now();

    // Zaman dilimi olarak kullanılacak 'Europe/Istanbul'
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(
      now.add(Duration(
          seconds: second ?? now.second,
          minutes: min ?? now.minute,
          hours: hour ?? now.hour)),
      tz.getLocation('Europe/Istanbul'),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title ?? 'Scheduled Title',
      content ?? 'Scheduled Content',
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'item x',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

