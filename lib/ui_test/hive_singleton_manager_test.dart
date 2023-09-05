import 'package:flutter/material.dart';
import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/product/model/task_model.dart';
import 'package:task_muse/product/utility/hive_manager.dart';

class HiveSingletonManagerTest extends StatefulWidget {
  const HiveSingletonManagerTest({Key? key}) : super(key: key);

  @override
  State<HiveSingletonManagerTest> createState() => _HiveSingletonManagerTestState();
}

class _HiveSingletonManagerTestState extends State<HiveSingletonManagerTest> {
  List<TaskModel>? _items;
  late final TaskCacheManager _instance;

  @override
  void initState() {
    super.initState();
    TaskCacheManager.initialize(key: CachingKeys.uiTestKey);
    _instance = TaskCacheManager.instance;
    _initAlize();
  }

  Future<void> _initAlize() async {
    await _instance.init();
    if(_instance.getValues?.isNotEmpty ?? false){
      _items = _instance.getValues;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TaskModel task = TaskModel(title: "test task",subTitle: "subtitle",date: "date",color: TaskModel.colorToString(AppColor.atomicOrange.getColor()));
          await _instance.addItem(task);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: (_items?.isNotEmpty ?? false) ? ListView.builder(
        itemCount: _items?.length,
        itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                      color: TaskModel.stringToColor(_items![index].color),
                      child: Center(
                    child: Text("${_items?[index].title}"),
                  ));
                },
      ) : const Center(child: CircularProgressIndicator()));
  }
}
//testleri yaptık gerekli color dönüşümlerini yaptık şimdi abi bunu ui testte yapalım!
//acaba tek bi yerde mi dosya olusutrabiliyor hive!
///aaa harbiden abi tek bir yerde olusuturcakmıs projedeki dataları! şuan görmeiyorum ama! ui_test url : lib/dataBase/ui_test_database
///
///