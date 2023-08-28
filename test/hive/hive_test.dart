import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/feature/main_page/model/task_model.dart';
import 'package:task_muse/product/utility/hive_manager.dart';

void main(){
  setUp(() {
    Hive.init("test/hive/test_database");
  });
  test("Hive addItem test", () async {
    final ICacheManager<TaskModel> _testCacheManager = TaskCacheManager(key: CachingKeys.testKey);
    await _testCacheManager.init();
    TaskModel model = TaskModel(color: "${AppColor.atomicOrange}", title: "furkan");
    await _testCacheManager.addItem(model);

    expect(_testCacheManager.getValues?.isNotEmpty,true);
  });

  test("Hive addItems and clear test", () async {
    final ICacheManager<TaskModel> _testCacheManager = TaskCacheManager(key: CachingKeys.testKey);
    await _testCacheManager.init();
    List<TaskModel> items = List.generate(5, (index) => TaskModel(color: "${AppColor.values[index]}", title: "$index"));
    await _testCacheManager.clearAll();
    await _testCacheManager.addItems(items);

    expect(_testCacheManager.getValues?.length, 5);
  });

  test("TaskCacheManager singleton test", () async {
    TaskCacheManager.initialize(key: CachingKeys.uiTestKey);
    final TaskCacheManager _instance = TaskCacheManager.instance;

    TaskModel task = TaskModel(title: "test task",subTitle: "subtitle",date: "date",color: TaskModel.colorToString(AppColor.atomicOrange.getColor()));
    await _instance.addItem(task);

    print(task.color);
    Color color = TaskModel.stringToColor(task.color);
    print(color);

    expect(task.title, "test task");
  });
}
