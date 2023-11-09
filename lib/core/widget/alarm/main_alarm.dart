import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

abstract class IMainAlarm{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  IMainAlarm({required this.flutterLocalNotificationsPlugin});

  void initialize();
  Future<void> showCustomMainAlarm();
}

class ScheduledNotificationTrigger extends IMainAlarm{
  ScheduledNotificationTrigger({required super.flutterLocalNotificationsPlugin});

  @override
  void initialize({String? androidNotificationIcon}){
    tzdata.initializeTimeZones();
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            androidNotificationIcon ?? "app_icon");
    DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> showCustomMainAlarm() async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );

    final tz.TZDateTime scheduledTime = tz.TZDateTime.now(tz.local).add(
      const Duration(seconds: 5),
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

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {}
}

class SoftAlarm extends IMainAlarm{
  SoftAlarm({required super.flutterLocalNotificationsPlugin});

  @override
  void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid  = AndroidInitializationSettings("");
    final DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> showCustomMainAlarm() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("denemeId", "DenemeName");
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();
    const NotificationDetails platformNotificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(0, "başlık", "body", platformNotificationDetails,payload: "yükleniyor");
  }
  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    //bildirimlere tıklandıgında olucak işlemler!
  }
}

