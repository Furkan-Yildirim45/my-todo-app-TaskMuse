import '../../../product/model/task_model.dart';

class MainPageState {
  List<TaskModel>? taskItems;
  bool? isLoading;

  MainPageState({
    this.taskItems,
    this.isLoading = false,
  });

  MainPageState copyWith({
    List<TaskModel>? taskItems,
    bool? isLoading,
  }) {
    return MainPageState(
      taskItems: taskItems ?? this.taskItems,
      isLoading: isLoading ?? false,
    );
  }
}
