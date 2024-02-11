import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/get_started/view/get_started_page_view.dart';
import 'package:task_muse/feature/home/model/personal_alarm_model.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/global/app_keys.dart';
import 'package:task_muse/product/model/global_model.dart';
import 'package:task_muse/product/utility/global_hive_manager.dart';
import '../../../core/const/colors.dart';
import '../../../feature/home/model/personal_tag_model.dart';
import '../../../feature/main_page/view/main_page.dart';
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
  }

  void makeIsSwipedFalse(){
    final tempList = state.taskItems ?? [];
    if(checkTaskItemsNotNullAndEmpty && state.changedCardIndex != null){
      tempList[state.changedCardIndex!].isSwiped = false;
    }
    emit(state.copyWith(taskItems: tempList,isAnyCardSwiped: false));
  }
  void makeIsActiveOfTagFalse(){
    final tempList = state.personalTags ?? [];
    for(var element in tempList){
      if(element.isActive){
        element.isActive = false;
      }
    }
    emit(state.copyWith(personalTags: tempList));
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

  Future<void> bottomSheetAddTaskMethod(BuildContext context, {required TextEditingController titleController}) async {
    final DateTime now = DateTime.now();
    final String dateNow = "${now.day}.${now.month}.${now.year}";
    final updatedTaskItemList = state.taskItems ?? [];
    final tempPersonalTagList = state.personalTags ?? [];
    final int tempPersonalTagIndex = tempPersonalTagList.indexWhere((element) => element.isActive);
    final hasTrueInPersonalAlarmHourItemList = state.personalAlarmHourItems?.contains(PersonalAlarmModel(isSelected: true));
    final hasTrueInPersonalAlarmMinuterItemList = state.personalAlarmMinutesItems?.contains(PersonalAlarmModel(isSelected: true));
    print("hasTrueInPersonalAlarmMinuterItemList : $hasTrueInPersonalAlarmMinuterItemList");
    print("hasTrueInPersonalAlarmHourItemList : $hasTrueInPersonalAlarmHourItemList");
    emit(state.copyWith(isLoading: true));
    if (titleController.text.isNotEmpty && tempPersonalTagIndex != -1) {
      final task = TaskModel(
        title: titleController.text,
        date: dateNow,
        color: TaskModel.colorToString(_selectedColor() ?? Colors.white),
        tag: tempPersonalTagList[tempPersonalTagIndex].tag,
        alarmHour: searchTrueInList(state.personalAlarmHourItems),
        alarmMinute: searchTrueInList(state.personalAlarmMinutesItems),
        isReminderActive: ((hasTrueInPersonalAlarmHourItemList ?? false) && (hasTrueInPersonalAlarmMinuterItemList ?? false)),
      );
      updatedTaskItemList.add(task);
      tempPersonalTagList[tempPersonalTagIndex].isActive = false;
      emit(state.copyWith(taskItems: updatedTaskItemList,personalTags: tempPersonalTagList));
      await TaskCacheManager.instance.addItem(task).then((value) {
        context.route.pop(true);
      });
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> bottomSheetEditTaskMethod(BuildContext context,{required TextEditingController titleController}) async{
    var tempTasksList = state.taskItems ?? [];
    var tempTagList = state.personalTags ?? [];
    final int tempTaskListIndex = tempTasksList.indexWhere((element) => element.isSwiped);
    final int tempTagListIndex = tempTagList.indexWhere((element) => element.isActive);
    emit(state.copyWith(isLoading: true));
    if(titleController.text.isNotEmpty){
      final task = TaskModel(
        color: tempTasksList[tempTaskListIndex].color,
        title: titleController.text,
        tag: (tempTagListIndex == -1) ? tempTasksList[tempTaskListIndex].tag : tempTagList[tempTagListIndex].tag,
        date: tempTasksList[tempTaskListIndex].date,
        alarmHour: searchTrueInList(state.personalAlarmHourItems) ?? tempTasksList[tempTaskListIndex].alarmHour,
        alarmMinute: searchTrueInList(state.personalAlarmMinutesItems) ?? tempTasksList[tempTaskListIndex].alarmMinute,
        isComplete: tempTasksList[tempTaskListIndex].isComplete,
        isReminderActive: tempTasksList[tempTaskListIndex].isReminderActive,
        isSwiped: tempTasksList[tempTaskListIndex].isSwiped,
      );
      tempTasksList.remove(tempTasksList[tempTaskListIndex]);
      tempTasksList.insert(tempTaskListIndex, task);
      emit(state.copyWith(taskItems: tempTasksList,personalTags: tempTagList,));
      context.route.pop();
      makeIsSwipedFalse();
      await TaskCacheManager.instance.clearAll();
      await TaskCacheManager.instance.addItems(tempTasksList);
    }
    emit(state.copyWith(isLoading: false));
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
    if(state.personalTags?.isNotEmpty ?? false){
      for(var value in state.personalTags!){
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
      context.route.pushReplacement(const MainPage());
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

  void setDefaultPersonalTags(){
    emit(state.copyWith(isLoading: true));
    List<PersonalTagModel>? tempList = [
      PersonalTagModel(tag: "Meeting", color: AppColor.aquaticCool.getColor()),
      PersonalTagModel(tag: "Mission", color: AppColor.candyDrop.getColor()),
      PersonalTagModel(tag: "Sports and Exercise", color: AppColor.mikadoYellow.getColor()),
      PersonalTagModel(tag: "Cleaning", color: AppColor.monastic.getColor()),
      PersonalTagModel(tag: "Shopping", color: AppColor.walledGarden.getColor()),
      PersonalTagModel(tag: "Bills", color: AppColor.dragonFly.getColor()),
      PersonalTagModel(tag: "Hobbies", color: AppColor.red.getColor()),
      PersonalTagModel(tag: "Homework", color: AppColor.pink.getColor()),
      PersonalTagModel(tag: "Cooking", color: AppColor.purple.getColor()),
      PersonalTagModel(tag: "Trip Planning", color: AppColor.teal.getColor()),
    ];
    emit(state.copyWith(personalTags: tempList,isLoading: false));
  }

  void toggleTag(int index){
    emit(state.copyWith(isLoading: true));
    final tempList = state.personalTags ?? [];
    if(tempList[index].isActive == false){
      tempList[index].isActive = true;
    }
    else if(tempList[index].isActive){
      tempList[index].isActive = false;
    }
    for(var item in tempList){
      if(tempList.indexOf(item) != index){
        item.isActive = false;
      }
    }
    emit(state.copyWith(isLoading: false));
  }

  bool get checkTaskItemsNotNullAndEmpty => ((state.taskItems?.isNotEmpty ?? false) && state.taskItems != null) ? true : false;

  void setDefaultAlarmHourItemsValue() {
    emit(state.copyWith(isLoading: true));
    var tempList = state.personalAlarmHourItems ?? [];
    tempList = PersonalAlarmModel.generateItems(count: 24);
    emit(state.copyWith(personalAlarmHourItems: tempList,isLoading: false));
  }
  void setDefaultAlarmMinuteItemsValue() {
    emit(state.copyWith(isLoading: true));
    var tempList = state.personalAlarmMinutesItems ?? [];
    tempList = PersonalAlarmModel.generateItems(count: 60);
    emit(state.copyWith(personalAlarmMinutesItems: tempList,isLoading: false));
  }

  void toggleAlarmMinutesItem(int index){
    emit(state.copyWith(isLoading: true));
    final tempList = state.personalAlarmMinutesItems ?? [];
    if(tempList[index].isSelected == false){
      tempList[index].isSelected = true;
    }
    else if(tempList[index].isSelected){
      tempList[index].isSelected = false;
    }
    for(var item in tempList){
      if(tempList.indexOf(item) != index){
        item.isSelected = false;
      }
    }
    emit(state.copyWith(isLoading: false,personalAlarmMinutesItems: tempList));
  }
  void toggleAlarmHourItems(int index){
    emit(state.copyWith(isLoading: true));
    final tempList = state.personalAlarmHourItems ?? [];
    if(tempList[index].isSelected == false){
      tempList[index].isSelected = true;
    }
    else if(tempList[index].isSelected){
      tempList[index].isSelected = false;
    }
    for(var item in tempList){
      if(tempList.indexOf(item) != index){
        item.isSelected = false;
      }
    }
    emit(state.copyWith(isLoading: false,personalAlarmHourItems: tempList));
  }

  int? searchTrueInList(List<PersonalAlarmModel>? list){
    var tempList = list ?? [];
    for(var element in tempList){
      if(element.isSelected){
        return tempList.indexOf(element);
      }
    }
    return null;
  }
}
