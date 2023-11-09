import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_muse/core/widget/alarm/main_alarm.dart';
import 'package:task_muse/core/widget/custom_elevated_button.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({Key? key}) : super(key: key);

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late final ScheduledNotificationTrigger scheduledNotificationTrigger;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    scheduledNotificationTrigger = ScheduledNotificationTrigger(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    scheduledNotificationTrigger.initialize();
    checkAndRequestPermission(); //todo: bir de izin istemden sonraya al!!!
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
      body: Center(
        child: CustomElevatedButton(
          child: const Text('5 saniye sonrasında alarm ekle'),
          onPressed: () {
            scheduledNotificationTrigger.showCustomMainAlarm();
          },
        ),
      ),
    );
  }
}

//todo: şimdi ilk kısım bitti ikinci kısım hatası butona bastıgımda gelen bi hata var ona bakıcam

/*
selam flutter kodluyorum ve bi hata alıyorum : kodda kullandıgım paket flutter_local_notifications ve bu paketi ilk başta entegrelerinde herhangi b sıkıntı yok bi buton koydum ve butona bastıgımda 5 sn sonrasına bildirim aldırma özelliği ekledim ama bu kodda bi hata alıyorum galiba bu yuzden koduma bakar mısın ? :import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_muse/core/widget/alarm/main_alarm.dart';
import 'package:task_muse/core/widget/custom_elevated_button.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({Key? key}) : super(key: key);

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late final ScheduledNotificationTrigger scheduledNotificationTrigger;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    scheduledNotificationTrigger = ScheduledNotificationTrigger(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
    scheduledNotificationTrigger.initialize();
    checkAndRequestPermission(); //todo: bir de izin istemden sonraya al!!!
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
      body: Center(
        child: CustomElevatedButton(
          child: const Text('5 saniye sonrasında alarm ekle'),
          onPressed: () {
            scheduledNotificationTrigger.showCustomMainAlarm();
          },
        ),
      ),
    );
  }
}

//todo: şimdi ilk kısım bitti ikinci kısım hatası butona bastıgımda gelen bi hata var ona bakıcam
   ; aldıgım hata da sudur :  [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: PlatformException(exact_alarms_not_permitted, Exact alarms are not permitted, null, null)
E/flutter (18779): #0      StandardMethodCodec.decodeEnvelope (package:flutter/src/services/message_codecs.dart:651:7)
E/flutter (18779): #1      MethodChannel._invokeMethod (package:flutter/src/services/platform_channel.dart:322:18)
E/flutter (18779): <asynchronous suspension>
E/flutter (18779): #2      AndroidFlutterLocalNotificationsPlugin.zonedSchedule (package:flutter_local_notifications/src/platform_flutter_local_notifications.dart:190:5)
E/flutter (18779): <asynchronous suspension>
E/flutter (18779): #3      FlutterLocalNotificationsPlugin.zonedSchedule (package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart:352:7)
E/flutter (18779): <asynchronous suspension>
E/flutter (18779): #4      ScheduledNotificationTrigger.showCustomMainAlarm (package:task_muse/core/widget/alarm/main_alarm.dart:54:5)
E/flutter (18779): <asynchronous suspension>
E/flutter (18779): */