/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';

mixin MainAlarm{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void mainAlarmInitialize(){
    const AndroidInitializationSettings initializationSettingsAndroid  = AndroidInitializationSettings("");
    final DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
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
}*/

//todo:suanda init ve show kısımları sıkıntı yok ama bi denemek lazım!
