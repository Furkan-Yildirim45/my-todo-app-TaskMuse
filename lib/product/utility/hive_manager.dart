import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_muse/core/const/hive_contants.dart';
import '../../feature/main_page/model/task_model.dart';

abstract class ICacheManager<T>{
  final CachingKeys key;
  Box<T>? _box;

  ICacheManager({required this.key});

  Future<void> init() async {
    registerAdapters();
    if(!(_box?.isOpen ?? false)){
      _box = await Hive.openBox(key.name);
    }
  }
  Future<void> clearAll() async {
    await _box?.clear();
  }
  List<T>? get getValues => _box?.values.toList();
  // Box<T>? getBox() => _box;
  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  Future<void> addItem(T model);
  Future<void> putItem(CachingKeys key,T model);
  T? getItem(CachingKeys key);
  Future<void> deleteItem(CachingKeys key);
  void registerAdapters();
}

class TaskCacheManager extends ICacheManager<TaskModel>{
  TaskCacheManager({required super.key});

  @override
  Future<void> addItems(List<TaskModel> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> putItems(List<TaskModel> items) async {
    await _box?.putAll(Map.fromEntries(items.map((element) => MapEntry(element.title, element)))); ///değiştirilicek! title
  }

  @override
  Future<void> addItem(TaskModel model) async {
    await _box?.add(model);
  }

  @override
  Future<void> putItem(CachingKeys key,TaskModel model) async {
    await _box?.put(key.name, model);
  }

  @override
  TaskModel? getItem(CachingKeys key){
    return _box?.get(key.name);
  }

  @override
  Future<void> deleteItem(CachingKeys key) async {
    await _box?.delete(key.name);
  }

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(HiveConstants.taskTypeId)){
      Hive.registerAdapter(TaskModelAdapter());
    }
  }
}

enum CachingKeys {
  taskToday,testKey
}