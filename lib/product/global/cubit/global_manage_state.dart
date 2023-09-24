
import '../../../feature/bottom_nav_bar/view/bottom_nav_bar_view.dart';
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

  GlobalManageState(
      {this.taskItems,
      this.isLoading = false,
      this.changedCardIndex,
      this.isAnyCardSwiped = false,
      this.globalModel,
      this.personalTags,
      this.tempNavBarIndex}){
    tempNavBarIndex = BottomNavItems.home.index;
  }

  GlobalManageState copyWith(
      {bool? isLoading,
      List<TaskModel>? taskItems,
      int? changedCardIndex,
      bool? isAnyCardSwiped,
      GlobalModel? globalModel,
      List<PersonalTagModel>? personalTags,
      int? tempNavBarIndex,}) {
    return GlobalManageState(
      isLoading: isLoading ?? this.isLoading,
      taskItems: taskItems ?? this.taskItems,
      changedCardIndex: changedCardIndex ?? this.changedCardIndex,
      isAnyCardSwiped: isAnyCardSwiped ?? this.isAnyCardSwiped,
      globalModel: globalModel ?? this.globalModel,
      personalTags: personalTags ?? this.personalTags,
      tempNavBarIndex: tempNavBarIndex ?? this.tempNavBarIndex,
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
          tempNavBarIndex == other.tempNavBarIndex;

  @override
  int get hashCode =>
      taskItems.hashCode ^
      isLoading.hashCode ^
      changedCardIndex.hashCode ^
      isAnyCardSwiped.hashCode ^
      globalModel.hashCode ^
      personalTags.hashCode ^
      tempNavBarIndex.hashCode;
}
