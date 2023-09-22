import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/global/provider/global_manage_provider.dart';
import 'package:task_muse/product/init/main_initialize.dart';
import 'core/const/colors.dart';
import 'core/theme/light_theme.dart';

Future<void> main() async {
  final MainInitialize mainInitialize = MainInitialize();
  await mainInitialize.hiveAndCacheManagerSingletonsInit();
  mainInitialize.globalCubitAndLoadTaskInit();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.aquaticCool.getColor()));
  runApp(
    Provider(
      create: (BuildContext context) => GlobalManageProvider.globalManageCubit,
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme().theme,
      debugShowCheckedModeBanner: false,
      home: context.read<GlobalManageCubit>().isAccountActiveAndGoPage(),
    );
  }
}

