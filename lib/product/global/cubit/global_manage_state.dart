

import '../../model/task_model.dart';

class GlobalManageState{
  List<TaskModel>? taskItems;
  bool? isLoading;
  int? changedCardIndex;
  bool? isAnyCardSwiped;

  GlobalManageState({this.taskItems, this.isLoading = false,this.changedCardIndex, this.isAnyCardSwiped = false});

  GlobalManageState copyWith({bool? isLoading,List<TaskModel>? taskItems,int? changedCardIndex,bool? isAnyCardSwiped}){
    return GlobalManageState(
      isLoading: isLoading ?? this.isLoading,
      taskItems: taskItems ?? this.taskItems,
      changedCardIndex: changedCardIndex ?? this.changedCardIndex,
      isAnyCardSwiped: isAnyCardSwiped ?? this.isAnyCardSwiped,
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
          isAnyCardSwiped == other.isAnyCardSwiped;

  @override
  int get hashCode => taskItems.hashCode ^ isLoading.hashCode ^ changedCardIndex.hashCode ^ isAnyCardSwiped.hashCode;
}