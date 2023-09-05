import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_muse/feature/get_started/view/get_started_page_view.dart';
import 'package:task_muse/product/init/main_initialize.dart';
import 'package:task_muse/ui_test/bottom_sheet_ui_test/bottom_sheet_ui_test.dart';
import 'core/const/colors.dart';
import 'core/theme/light_theme.dart';

Future<void> main() async {
  MainInitialize().hiveAndSingletonInit();
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
      home: const BottomSheetUiTest(),
    );
  }
}

