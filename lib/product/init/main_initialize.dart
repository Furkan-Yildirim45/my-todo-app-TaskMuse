
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_muse/product/global/app_boxes.dart';
import 'package:task_muse/product/utility/global_hive_manager.dart';
import 'package:task_muse/product/utility/hive_manager.dart';
import '../global/app_keys.dart';
import '../global/cubit/global_manage_cubit.dart';
import '../global/provider/global_manage_provider.dart';

class MainInitialize{
  late final GlobalManageCubit _globalManageCubit;
  final String _databaseUrl = "lib/dataBase";

  Future<void> hiveAndCacheManagerSingletonsInit() async {
    await Hive.initFlutter(_databaseUrl);
    TaskCacheManager.initialize(key: CachingKeys.taskListKey);
    GlobalCacheManager.instanceInitialize(boxKey: CachingBoxes.globalBox);
    await TaskCacheManager.instance.init();
    await GlobalCacheManager.instance.boxInit();
  }

  void globalCubitAndLoadTaskInit(){
    _globalManageCubit = GlobalManageCubit();
    _globalManageCubit.setDefaultTaskItems();
    _globalManageCubit.setDefaultGlobalModel();
    _globalManageCubit.setDefaultPersonalTags();
    GlobalManageProvider.init(_globalManageCubit);
  }

}