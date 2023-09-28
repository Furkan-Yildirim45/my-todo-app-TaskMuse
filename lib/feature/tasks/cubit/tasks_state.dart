import '../../../product/model/task_model.dart';

class TasksState {
  List<TaskModel>? taskItems;
  bool? isSearchActive;
  bool? isLoading;
  bool? isClickClear;

  TasksState(
      {this.taskItems, this.isSearchActive = false, this.isLoading = false, this.isClickClear = false});

  TasksState copyWith(
      {List<TaskModel>? taskItems,
      bool? isSearchActive,
      bool? isLoading,
      bool? isClickClear}) {
    return TasksState(
        isLoading: isLoading ?? false,
        taskItems: taskItems ?? this.taskItems,
        isClickClear: isClickClear ?? false,
        isSearchActive: isSearchActive ?? false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksState &&
          runtimeType == other.runtimeType &&
          taskItems == other.taskItems &&
          isSearchActive == other.isSearchActive &&
          isLoading == other.isLoading &&
          isClickClear == other.isClickClear;

  @override
  int get hashCode =>
      taskItems.hashCode ^
      isSearchActive.hashCode ^
      isLoading.hashCode ^
      isClickClear.hashCode;
}
