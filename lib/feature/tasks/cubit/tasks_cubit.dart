import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/tasks/cubit/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState());
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