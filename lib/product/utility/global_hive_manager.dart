
import 'package:hive_flutter/adapters.dart';
import 'package:task_muse/core/const/hive_contants.dart';
import 'package:task_muse/product/exception/global_cache_manager_exception.dart';
import 'package:task_muse/product/global/app_boxes.dart';
import 'package:task_muse/product/global/app_keys.dart';
import 'package:task_muse/product/model/global_model.dart';

class GlobalCacheManager{
  final CachingBoxes boxKey;
  Box<GlobalModel>? _box;
  static GlobalCacheManager? _instance;

  GlobalCacheManager({required this.boxKey});

  static GlobalCacheManager get instance {
    if (_instance == null) {
      throw GlobalCacheManagerException();
    }
    return _instance!;
  }

  static void instanceInitialize({required CachingBoxes boxKey}) {
    _instance ??= GlobalCacheManager(boxKey: boxKey);
  }

  Future<void> boxInit() async {
    registerAdaptor();
    if(!(_box?.isOpen ?? false)){
      _box = await Hive.openBox(boxKey.name);
    }
  }

  Future<void> addOrPutItem(CachingKeys key,GlobalModel data) async {
    await _box?.put(key.name, data);
  }
  GlobalModel? getItem(CachingKeys key){
    return _box?.get(key.name);
  }
  Future<void> deleteItem(CachingKeys key) async {
    await _box?.delete(key.name);
  }
  Future<void> clearAll() async {
    await _box?.clear();
  }

  void registerAdaptor(){
    if(!Hive.isAdapterRegistered(HiveConstants.globalTypeId)){
      Hive.registerAdapter(GlobalModelAdapter());
    }
  }
}
