

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_muse/product/utility/hive_manager.dart';

class MainInitialize{
  final String _databaseUrl = "lib/dataBase";

  Future<void> hiveAndSingletonInit() async {
    await Hive.initFlutter(_databaseUrl);
    TaskCacheManager.initialize(key: CachingKeys.taskList);
    await TaskCacheManager.instance.init();
  }
}