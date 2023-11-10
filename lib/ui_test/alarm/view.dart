import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
void main() {
  tzdata.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notifications Example'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _showNotification();
              },
              child: Text('Show Notification'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _scheduleNotification();
              },
              child: Text('Show schedukeNotification'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'id_1',
      'zamansal_name',
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
      now.add(const Duration(seconds: 2)),
      tz.getLocation('Europe/Istanbul'),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Scheduled Title',
      'Scheduled Content',
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
