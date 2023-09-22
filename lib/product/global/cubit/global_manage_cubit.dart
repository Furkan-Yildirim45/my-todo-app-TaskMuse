import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/get_started/view/get_started_page_view.dart';
import 'package:task_muse/feature/main_page/view/main_page_view.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/global/app_keys.dart';
import 'package:task_muse/product/model/global_model.dart';
import 'package:task_muse/product/utility/global_hive_manager.dart';
import '../../../core/general_datas.dart';
import '../../model/task_model.dart';
import '../../utility/hive_manager.dart';
import 'global_manage_state.dart';

class GlobalManageCubit extends Cubit<GlobalManageState> {
  GlobalManageCubit() : super(GlobalManageState());

  Future<void> changeReminder(int index) async {
    final tempList = state.taskItems ?? [];
    state.copyWith(isLoading: true);
    if(checkTaskItemsNotNullAndEmpty){
      if(state.taskItems?[index].isComplete == false){
        tempList[index].isReminderActive = !(tempList[index].isReminderActive);
      }
      else{
        tempList[index].isReminderActive = false;
      }
    }
    emit(state.copyWith(taskItems: tempList,isLoading: false));
    await TaskCacheManager.instance.clearAll();
    await TaskCacheManager.instance.addItems(tempList);
  }

  Future<void> changeIsComplete(int index) async {
    final tempList = state.taskItems ?? [];
    emit(state.copyWith(isLoading: true));
    if(checkTaskItemsNotNullAndEmpty){
      tempList[index].isComplete = !(tempList[index].isComplete);
    }
    if(state.taskItems?[index].isReminderActive ?? false){
      tempList[index].isReminderActive = false;
    }
    emit(state.copyWith(isLoading: false,taskItems: tempList));
    await TaskCacheManager.instance.clearAll();
    await TaskCacheManager.instance.addItems(tempList);
  }

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
    final tempList = state.taskItems ?? [];
    if(checkTaskItemsNotNullAndEmpty){
      tempList[state.changedCardIndex!].isSwiped = false;
    }
    emit(state.copyWith(taskItems: tempList,isAnyCardSwiped: false));
    print(swipedController);
  }

  void setDefaultTaskItems()  {
    emit(state.copyWith(isLoading: true));
    if(TaskCacheManager.instance.getValues?.isNotEmpty ?? false){ //for taskItems
      emit(state.copyWith(taskItems: TaskCacheManager.instance.getValues));
    }
    else {
      emit(state.copyWith(taskItems: []));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> bottomSheetAddTaskMethod(BuildContext context, {required TextEditingController titleController, required TextEditingController subtitleController}) async {
    final DateTime now = DateTime.now();
    final String dateNow = "${now.day}.${now.month}.${now.year}";
    final updatedList = state.taskItems ?? [];
    emit(state.copyWith(isLoading: true));
    if (titleController.text.isNotEmpty) {
      final task = TaskModel(
        title: titleController.text,
        date: dateNow,
        color: TaskModel.colorToString(_selectedColor() ?? Colors.white), tag: 'Tag Place',
      );
      updatedList.add(task);
      emit(state.copyWith(taskItems: updatedList,isLoading: false));
      await TaskCacheManager.instance.addItem(task).then((value) {
        context.route.pop();
      });
    }
  }

  Future<void> deleteTaskItem({required int index,required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    final updatedList = state.taskItems ?? [];
    if(checkTaskItemsNotNullAndEmpty){
      updatedList.remove(updatedList[index]);
    }
    emit(state.copyWith(taskItems: updatedList,isLoading: false));
    await TaskCacheManager.instance.clearAll();
    await TaskCacheManager.instance.addItems(updatedList).then((value) {
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

  Future<void> accountActive(BuildContext context) async {
    GlobalModel tempModel = GlobalModel();
    emit(state.copyWith(isLoading: true));
    tempModel.isAccountActive = true;
    emit(state.copyWith(globalModel: tempModel));
    emit(state.copyWith(isLoading: false));
    await GlobalCacheManager.instance.addOrPutItem(CachingKeys.globalModelKey, state.globalModel ?? GlobalModel()).then((value) {
      context.route.navigatePush(const MainPage());
    });
  }
  Widget isAccountActiveAndGoPage() {
    if(state.globalModel?.isAccountActive ?? false){
      return const MainPage();
      //splash ekranı şimdilik mainPage
    }
    else{
      return const GetStartedPage();
    }
  }

  void setDefaultGlobalModel(){
    emit(state.copyWith(isLoading: true));
    if(GlobalCacheManager.instance.getItem(CachingKeys.globalModelKey) != null){
      emit(state.copyWith(globalModel: GlobalCacheManager.instance.getItem(CachingKeys.globalModelKey)));
    }
    else{
      emit(state.copyWith(globalModel: GlobalModel()));
    }
    emit(state.copyWith(isLoading: false));
  }

  bool get checkTaskItemsNotNullAndEmpty => ((state.taskItems?.isNotEmpty ?? false) && state.taskItems != null) ? true : false;
}

