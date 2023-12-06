import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import 'main_alarm.dart';

void main() async {
  // timezone paketini başlat
  tzdata.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late final NotificationHelper notificationHelper;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    notificationHelper = NotificationHelper(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    await notificationHelper.requestNotificationPermissions();
    await notificationHelper.initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Local Notifications Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Bildirim göster
                  await notificationHelper.showNotification(
                    title: 'Test Notification',
                    content: 'This is a test notification.',
                  );
                },
                child: Text('Show Notification'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Zamanlanmış bildirim göster
                  await notificationHelper.scheduleNotification(
                    flutterLocalNotificationsPlugin,
                    title: 'Scheduled Notification',
                    content: 'This is a scheduled notification.',
                  );
                },
                child: Text('Schedule Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///todo: anlık bildiirm geliyor ama zamansal bildirim gelmiyor. herşey halledildi emulator zamanı,
///ikonlar olsun manifest dosyaları drawable vs vs !!! mipmap
///
/// todo: son durum hata yok ama calısmıyor bildirim