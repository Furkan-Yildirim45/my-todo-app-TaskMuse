
import '../../../feature/main_page/view/bottom_nav_bar_view.dart';
import '../../../feature/home/model/personal_alarm_model.dart';
import '../../../feature/home/model/personal_tag_model.dart';
import '../../model/global_model.dart';
import '../../model/task_model.dart';

class GlobalManageState{
  List<TaskModel>? taskItems;
  bool? isLoading;
  int? changedCardIndex;
  bool? isAnyCardSwiped;
  GlobalModel? globalModel;
  List<PersonalTagModel>? personalTags;
  int? tempNavBarIndex;
  List<PersonalAlarmModel>? personalAlarmHourItems;
  List<PersonalAlarmModel>? personalAlarmMinutesItems;

  GlobalManageState(
      {this.taskItems,
      this.isLoading = false,
      this.changedCardIndex,
      this.isAnyCardSwiped = false,
      this.globalModel,
      this.personalTags,
      this.tempNavBarIndex,
      this.personalAlarmHourItems,
      this.personalAlarmMinutesItems}){
    tempNavBarIndex = BottomNavItems.home.index;

  }

  GlobalManageState copyWith(
      {bool? isLoading,
      List<TaskModel>? taskItems,
      int? changedCardIndex,
      bool? isAnyCardSwiped,
      GlobalModel? globalModel,
      List<PersonalTagModel>? personalTags,
      int? tempNavBarIndex,
      List<PersonalAlarmModel>? personalAlarmHourItems,
        List<PersonalAlarmModel>? personalAlarmMinutesItems}) {
    return GlobalManageState(
      isLoading: isLoading ?? this.isLoading,
      taskItems: taskItems ?? this.taskItems,
      changedCardIndex: changedCardIndex ?? this.changedCardIndex,
      isAnyCardSwiped: isAnyCardSwiped ?? this.isAnyCardSwiped,
      globalModel: globalModel ?? this.globalModel,
      personalTags: personalTags ?? this.personalTags,
      tempNavBarIndex: tempNavBarIndex ?? this.tempNavBarIndex,
      personalAlarmHourItems: personalAlarmHourItems ?? this.personalAlarmHourItems,
      personalAlarmMinutesItems: personalAlarmMinutesItems ?? this.personalAlarmMinutesItems
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalManageState &&
          runtimeType == other.runtimeType &&
          taskItems == other.taskItems &&
          isLoading == other.isLoading &&
          changedCardIndex == other.changedCardIndex &&
          isAnyCardSwiped == other.isAnyCardSwiped &&
          globalModel == other.globalModel &&
          personalTags == other.personalTags &&
          tempNavBarIndex == other.tempNavBarIndex &&
          personalAlarmHourItems == other.personalAlarmHourItems &&
          personalAlarmMinutesItems == other.personalAlarmMinutesItems;

  @override
  int get hashCode =>
      taskItems.hashCode ^
      isLoading.hashCode ^
      changedCardIndex.hashCode ^
      isAnyCardSwiped.hashCode ^
      globalModel.hashCode ^
      personalTags.hashCode ^
      tempNavBarIndex.hashCode ^
      personalAlarmHourItems.hashCode ^
      personalAlarmMinutesItems.hashCode;
}
