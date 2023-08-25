import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/const/colors.dart';
import 'core/theme/light_theme.dart';
import 'feature/get_started/view/get_started_page_view.dart';

Future<void> main() async {
  //bu kod statusbar coloruna eriştiriyor
  await Hive.initFlutter("lib/dataBase");
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.aquaticCool.getColor()));
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

