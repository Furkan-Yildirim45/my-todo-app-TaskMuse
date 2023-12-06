import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:task_muse/ui_test/notification_helper/notification_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager.initialize();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }
  Future<void> checkAndRequestSchedulePermission() async { //todo: baba herşey okey bak sadece schedule için izin alamıyorum ona bak!!!!!
    final scheduleStatus = await Permission.scheduleExactAlarm.status;
    if(scheduleStatus.isGranted || scheduleStatus.isLimited){}
    else{
      final notificationResult = await Permission.scheduleExactAlarm.request();
      if (notificationResult.isGranted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('notificationSchedulePermission', true);
      }
    }
  }

    Future<void> checkAndRequestPermission() async {
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus.isGranted || notificationStatus.isLimited) {
    } else {
      final notificationResult = await Permission.notification.request();
      if (notificationResult.isGranted) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('notificationPermission', true);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Local Notifications Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await checkAndRequestPermission();
                  await NotificationManager.showNotification(
                    id: 0,
                    title: "title",
                    body: "body",
                    payload: 'item x',
                  );
                },
                child: const Text('Show Notification'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await checkAndRequestSchedulePermission();
                  final DateTime now = DateTime.now();
                  final tz.TZDateTime scheduledTime = tz.TZDateTime.from(
                    now.add(Duration(
                        seconds: now.second + 3,
                        minutes: now.minute,
                        hours: now.hour)),
                    tz.getLocation('Europe/Istanbul'),
                  );
                  // Zamanlanmış bildirim göster
                  NotificationManager.scheduleNotification(
                      id: 1,
                      title: "title",
                      body: "body",
                      payload: "item x",
                      scheduledDateTime: scheduledTime);
                },
                child: const Text('Schedule Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
