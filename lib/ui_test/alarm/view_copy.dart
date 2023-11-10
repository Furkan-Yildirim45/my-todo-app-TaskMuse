import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_muse/product/utility/main_alarm.dart';
import 'package:task_muse/core/widget/custom_elevated_button.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({Key? key}) : super(key: key);

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late final ScheduledOrNowNotificationTrigger _notificationTrigger;
  @override
  void initState() {
    super.initState();
    checkAndRequestPermission();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _notificationTrigger = ScheduledOrNowNotificationTrigger(flutterLocalNotificationsPlugin);
  }

  Future<void> checkAndRequestPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted || status.isLimited) {
      // İzin verildi veya sınırlı izin varsa işlem yapabilirsiniz.
    } else {
      // İzin alınmamış veya reddedilmişse izin iste.
      final result = await Permission.notification.request();
      if (result.isGranted) {
        // İzin verildi, bu izni sakla.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('notificationPermission', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Deneme')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomElevatedButton(
              child: const Text('5 saniye sonrasında alarm ekle'),
              onPressed: () {
                _notificationTrigger.scheduleNotification(title: "Zamansal Alarm",second: 5);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomElevatedButton(
                child: const Text('alarm ekle'),
                onPressed: () {
                    _notificationTrigger.showNotification(title: "Zamansal olmayan Alarm");
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
