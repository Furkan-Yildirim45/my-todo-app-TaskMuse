import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/tasks/cubit/tasks_state.dart';
import 'package:task_muse/product/utility/hive_manager.dart';

import '../../../product/model/task_model.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState());


  List<TaskModel>? getDefaultTaskItems(){
    emit(state.copyWith(isLoading: true));
    if(TaskCacheManager.instance.getValues?.isNotEmpty ?? false){
      emit(state.copyWith(taskItems: TaskCacheManager.instance.getValues));
      return state.taskItems;
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }

  void changeIsSearchActive(){
    emit(state.copyWith(isSearchActive: !(state.isSearchActive ?? false)));
  }
  void makeFalseIsSearchActive(){
    emit(state.copyWith(isSearchActive: false));
  }
  void makeTrueIsClickClear(){
    emit(state.copyWith(isClickClear: true,isSearchActive: true));
  }
  void makeFalseIsClickClear(){
    emit(state.copyWith(isClickClear: false));
  }
}