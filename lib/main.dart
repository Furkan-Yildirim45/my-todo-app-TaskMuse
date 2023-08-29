import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_muse/feature/get_started/view/get_started_page_view.dart';
import 'core/const/colors.dart';
import 'core/theme/light_theme.dart';

Future<void> main() async {
  //bu kod statusbar coloruna eriştiriyor
  const String databaseUrl = "lib/dataBase";
  await Hive.initFlutter(databaseUrl);
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

//state güncellemesini bi araştırıcam managment olmadan önce ve suanda code recover complete!
//caching işlemi başarılı fakat ekledigimde setState olmuyor bunu statemanagment ile çözücem,bunu çözmeden önce projeyi bi temiz hale çekiyim!
