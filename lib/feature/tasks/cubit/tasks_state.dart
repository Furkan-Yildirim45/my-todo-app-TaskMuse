import '../../../product/model/task_model.dart';

class TasksState {
  bool? isSearchActive;
  bool? isClickClear;

  TasksState(
      {this.isSearchActive = false, this.isClickClear = false});

  TasksState copyWith(
      {List<TaskModel>? taskItems,
      bool? isSearchActive,
      bool? isLoading,
      bool? isClickClear}) {
    return TasksState(
        isClickClear: isClickClear ?? false,
        isSearchActive: isSearchActive ?? false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksState &&
          runtimeType == other.runtimeType &&
          isSearchActive == other.isSearchActive &&
          isClickClear == other.isClickClear;

  @override
  int get hashCode =>
      isSearchActive.hashCode ^
      isClickClear.hashCode;
}
