import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/core/widget/custom_animation_elev_button.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';

import '../../../product/global/cubit/global_manage_state.dart';
import '../../../product/widget/category_button.dart';

part 'bottom_sheet_parts/part_of_tags_place.dart';

class MainPageBottomSheet extends StatefulWidget {
  const MainPageBottomSheet({
    super.key,
  });

  @override
  State<MainPageBottomSheet> createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet> with _BottomSheetUtility{
  late final ScrollController _scrollController;
  late final TextEditingController _titleController;
  int? hour = 0;
  int? minute = 0;
  @override
  void initState() {
    super.initState();
    context.read<GlobalManageCubit>().setDefaultAlarmMinuteItemsValue();
    context.read<GlobalManageCubit>().setDefaultAlarmHourItemsValue();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _addNewTaskText(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleTextFormField(),
              _categoryText(context),
              const _TagsPlace(),
              _addAlarmText(context),
              BlocBuilder<GlobalManageCubit, GlobalManageState>(
                builder: (context, state) {
                  return Padding(
                    padding: context.padding.normalSymmetricVertical,
                    child: SizedBox(
                      height: context.sized.dynamicHeigth(0.25),
                      child: Row(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemCount: state.personalAlarmHourItems?.length ?? 0,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return CustomAnimationElevatedButton(
                                containerMargin: ((state.personalAlarmHourItems?.length ?? 0) -1) == index
                                    ? context.padding.kZeroPadding
                                    : context.padding.bottomOnlyNormal,
                                containerPadding: context.padding.dynamicSymmetric(vertical: 0, horizontal: 0.06),
                                  buttonShape: RoundedRectangleBorder(
                                    borderRadius: context.border.largeBorderRadius
                                  ),
                                  buttonBackgroundColor:
                                      (state.personalAlarmHourItems?[index].isSelected ?? false)
                                          ? const Color(0xff00CCFF)
                                          : AppColor.enoki.getColor(),
                                  onPressed: () {
                                    context.read<GlobalManageCubit>().toggleAlarmHourItems(index);
                                  },
                                  containerDuration:
                                      context.duration.durationNormal,
                                  child: Center(
                                      child: Text(
                                    (index % 24).toString(),
                                    style: context.general.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: (state.personalAlarmHourItems?[index].isSelected ?? false)
                                              ? Colors.white
                                              : Colors.black
                                    ),
                                  )));
                            },
                          )),
                          Expanded(
                              child: ListView.builder(
                            itemCount:
                                state.personalAlarmMinutesItems?.length ?? 0,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return CustomAnimationElevatedButton(
                                  containerMargin: ((state.personalAlarmMinutesItems?.length ?? 0) -1) == index
                                      ? context.padding.kZeroPadding
                                      : context.padding.bottomOnlyNormal,
                                  containerPadding: context.padding.dynamicSymmetric(vertical: 0, horizontal: 0.06),
                                  buttonShape: RoundedRectangleBorder(
                                      borderRadius: context.border.largeBorderRadius
                                  ),
                                  buttonBackgroundColor:
                                  (state.personalAlarmMinutesItems?[index].isSelected ?? false)
                                      ? const Color(0xff00CCFF)
                                      : AppColor.enoki.getColor(),
                                  onPressed: () {
                                    context.read<GlobalManageCubit>().toggleAlarmMinutesItem(index);
                                  },
                                  containerDuration:
                                  context.duration.durationNormal,
                                  child: Center(
                                      child: Text(
                                        (index % 60).toString(),
                                        style: context.general.textTheme.headlineSmall
                                            ?.copyWith(
                                            color: (state.personalAlarmMinutesItems?[index].isSelected ?? false)
                                                ? Colors.white
                                                : Colors.black
                                        ),
                                      )));
                            },
                          )),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          const Spacer(),
          _addTaskButton(context)
        ],
      ),
    );
  }

  Padding _addAlarmText(BuildContext context) {
    return Padding(
              padding: context.padding.topOnlyNormal,
              child: Text(addAlarmText),
            );
  }

  Padding _categoryText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyNormal,
      child: Text(categoryText),
    );
  }

  TextFormField _titleTextFormField() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: addTaskTitle,
      ),
      maxLength: 100,
    );
  }

  Padding _addTaskButton(BuildContext context) {
    return Padding(
      padding: context.padding.bottomOnlyNormal,
      child: SizedBox(
        width: context.sized.dynamicWidth(0.6),
        height: context.sized.floatActionButtonSize,
        child: ElevatedButton(
          onPressed: () {
            context.read<GlobalManageCubit>().bottomSheetAddTaskMethod(context, titleController: _titleController);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColor.aquaticCool.getColor()),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: context.border.largeBorderRadius))),
          child: Text(
            addTaskText,
            style: context.general.textTheme.titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Text _addNewTaskText(BuildContext context) => Text(addNewTaskText, style: context.general.textTheme.titleLarge);
}

mixin _BottomSheetUtility {
  final String addNewTaskText = "Add new task";
  final String addTaskText = "Add task";
  final String tampDateText = "Temp Date!";
  final String addTaskTitle = "Add Task Title";
  final String categoryText = "Category";
  final String addAlarmText = "Add alarm";
}

//todo:knk burda alarm eklerken hem saatin hem de dk nın verilmesi gerekli diger türlü olarak default bi dk saat ataması yap
//bunu ayarla bunu yaptıkdan sonra da düzeltme butonuyla tıklandıktan sonra giden sayfayı yapıcaksın!