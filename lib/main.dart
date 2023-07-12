import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_muse/const/colors.dart';
import 'package:task_muse/get_started_page.dart';
import 'package:task_muse/theme.dart';

void main() {
  //bu kod statusbar coloruna eriştiriyor
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ProjectColors().aquaticCool));
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme().theme,
      debugShowCheckedModeBanner: false,
      home: const GetStartedPage(),
    );
  }
}
