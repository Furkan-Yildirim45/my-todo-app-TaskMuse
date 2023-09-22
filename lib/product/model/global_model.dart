
import 'package:hive_flutter/adapters.dart';
import 'package:task_muse/core/const/hive_contants.dart';
part 'global_model.g.dart';

@HiveType(typeId: HiveConstants.globalTypeId)
class GlobalModel{
  @HiveField(0)
  bool isAccountActive;
  @HiveField(1)
  bool isThemeDark;
  GlobalModel({this.isAccountActive = false,this.isThemeDark = false});
}