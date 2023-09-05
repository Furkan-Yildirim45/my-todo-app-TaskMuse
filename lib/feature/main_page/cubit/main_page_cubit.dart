
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/utility/hive_manager.dart';
import '../../../core/general_datas.dart';
import '../../../product/model/task_model.dart';
import 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageState());

  void setItemsToTaskItems()  {
    emit(state.copyWith(isLoading: true));
    if(TaskCacheManager.instance.getValues?.isNotEmpty ?? false){
      emit(state.copyWith(taskItems: TaskCacheManager.instance.getValues));
    }
    emit(state.copyWith(isLoading: false));
  }

  void _addTaskToCubit(TaskModel task) {
    final updatedList = state.taskItems?.toList();
    updatedList?.add(task);
    emit(state.copyWith(taskItems: updatedList));
  }

  Future<void> bottomSheetAddTaskMethod(BuildContext context,
      {required TextEditingController titleController,
        required TextEditingController subtitleController}) async {
    if (titleController.text.isNotEmpty && subtitleController.text.isNotEmpty) {
      final task = TaskModel(
        title: titleController.text,
        subTitle: subtitleController.text,
        date: "date",
        color: TaskModel.colorToString(_selectedColor() ?? Colors.white),
      );
      await TaskCacheManager.instance.addItem(task).whenComplete(() {
        _addTaskToCubit(task);
        context.route.pop();
      });
    }
    //dönen olay şu: önce task verilerini atıyor daha sonra veriler check ediliyor sonra burda önce caching yapılıyor sonra bu liste güncelleniyor!
  }

  Color? _selectedColor(){
    if(GeneralDatas.personalColor?.isNotEmpty ?? false){
      for(var value in GeneralDatas.personalColor!){
        if(value.isActive) return value.color;
      }
    }
    return null;
  }
  //senaryom su: ben bi degerim var bu default height degeri state.taskItems.length i her attıgında bu degeri çarptırıyorum ve burdaki height a atıyorum
}
