import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import '../../../core/general_datas.dart';
import '../../model/task_model.dart';
import '../../utility/hive_manager.dart';
import 'global_manage_state.dart';

class GlobalManageCubit extends Cubit<GlobalManageState> {
  GlobalManageCubit() : super(GlobalManageState());

  void changeIsSwiped(int cardIndex) {
    final tempList = state.taskItems ?? [];
    bool swipedValue = state.isAnyCardSwiped ?? false;
    if(state.changedCardIndex == null){
      tempList[cardIndex].isSwiped = true;
      swipedValue = true;
    }
    else if(state.changedCardIndex != cardIndex){
      tempList[state.changedCardIndex!].isSwiped = false;
      tempList[cardIndex].isSwiped = true;
      swipedValue = true;
    }
    else{
      tempList[state.changedCardIndex!].isSwiped = !(tempList[state.changedCardIndex!].isSwiped);
      swipedValue = tempList[state.changedCardIndex!].isSwiped;
    }
    emit(state.copyWith(taskItems: tempList,changedCardIndex: cardIndex,isAnyCardSwiped: swipedValue));
    print(swipedValue);
  }

  bool get swipedController => state.isAnyCardSwiped!;

  void makeIsSwipedFalse(){
    final tempList = state.taskItems;
    if(checkTaskItemsNotNullAndEmpty){
      tempList![state.changedCardIndex!].isSwiped = false;
    }
    emit(state.copyWith(taskItems: tempList,isAnyCardSwiped: false));
    print(swipedController);
  }

  void setItemsToTaskItems()  {
    emit(state.copyWith(isLoading: true));
    if(TaskCacheManager.instance.getValues?.isNotEmpty ?? false){
      emit(state.copyWith(taskItems: TaskCacheManager.instance.getValues));
    }
    else {
      emit(state.copyWith(taskItems: []));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> bottomSheetAddTaskMethod(BuildContext context,
      {required TextEditingController titleController,
        required TextEditingController subtitleController}) async {
    emit(state.copyWith(isLoading: true));
    if (titleController.text.isNotEmpty && subtitleController.text.isNotEmpty) {
      final task = TaskModel(
        title: titleController.text,
        subTitle: subtitleController.text,
        date: "date",
        color: TaskModel.colorToString(_selectedColor() ?? Colors.white),
      );
      final updatedList = state.taskItems ?? [];
      updatedList.add(task);
      emit(state.copyWith(taskItems: updatedList,isLoading: false));
      await TaskCacheManager.instance.addItem(task).then((value) {
        context.route.pop();
      });
    }
  }

  Future<void> deleteTaskItem({required int index,required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    final updatedList = state.taskItems;
    if(checkTaskItemsNotNullAndEmpty){
      updatedList!.remove(updatedList[index]);
    }
    emit(state.copyWith(taskItems: updatedList,isLoading: false));
    await TaskCacheManager.instance.clearAll();
    await TaskCacheManager.instance.addItems(updatedList!).then((value) {
      context.route.pop();
    });
    ///alert dialog ve sheet componentlerinde procProvider ile sarmalaman lazım! o sekilde oluyor!
  }

  Color? _selectedColor(){
    if(GeneralDatas.personalColor?.isNotEmpty ?? false){
      for(var value in GeneralDatas.personalColor!){
        if(value.isActive) return value.color;
      }
    }
    return null;
  }

  bool get checkTaskItemsNotNullAndEmpty => ((state.taskItems?.isNotEmpty ?? false) && state.taskItems != null) ? true : false;
}
