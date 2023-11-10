import 'package:flutter/material.dart';
import 'package:task_muse/ui_test/alarm/view_copy.dart';
import 'package:timezone/data/latest.dart' as tzdata;
void main(){
  tzdata.initializeTimeZones();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AlarmView(),
    );
  }
}