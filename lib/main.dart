import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/tasks/cubit/tasks_cubit.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalManageProvider.globalManageCubit,),
        BlocProvider(create: (context) => TasksCubit(),),
      ],
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

/* //bu kısım globalContext için!
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
}*/
