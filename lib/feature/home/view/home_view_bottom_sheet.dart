import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/utility/notification_manager.dart';

import '../../../product/global/cubit/global_manage_state.dart';
import '../../../product/widget/alarm_button.dart';
import '../../../product/widget/category_button.dart';
import '../model/personal_alarm_model.dart';

part 'bottom_sheet_parts/part_of_tags_place.dart';

class HomePageBottomSheet extends StatefulWidget {
  const HomePageBottomSheet({
    super.key, required this.isEdit,
  });
  final bool isEdit;
  @override
  State<HomePageBottomSheet> createState() => _HomePageBottomSheetState();
}

class _HomePageBottomSheetState extends State<HomePageBottomSheet> with _BottomSheetUtility{
  @override
  void initState() {
    super.initState();
    context.read<GlobalManageCubit>().setDefaultAlarmMinuteItemsValue();
    context.read<GlobalManageCubit>().setDefaultAlarmHourItemsValue();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _initNotification();
  }

  Future<void> _initNotification() async {
    _notificationManager = NotificationManager();
    await _notificationManager.initializeNotification(null);
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
              _addAlarm()
            ],
          ),
          const Spacer(),
          _addTaskButton(context)
        ],
      ),
    );
  }
}


mixin _BottomSheetUtility on State<HomePageBottomSheet>{
  final String addNewTaskText = "Add new task";
  final String editTheTaskText = "Edit the task";
  final String addTaskText = "Add task";
  final String editTaskText = "Edit task";
  final String tampDateText = "Temp Date!";
  final String addTaskTitle = "Add Task Title";
  final String editTaskTitle = "Edit Task Title";
  final String categoryText = "Add category";
  final String editCategoryText = " Edit category";
  final String addAlarmText = "Add alarm";
  final String editAlarmText = "Edit alarm";

  late final NotificationManager _notificationManager;
  late final ScrollController _scrollController;
  late final TextEditingController _titleController;
  int? hour = 0;
  int? minute = 0;

  void edit() => context.read<GlobalManageCubit>().bottomSheetEditTaskMethod(context, titleController: _titleController);
  void add() => context.read<GlobalManageCubit>().bottomSheetAddTaskMethod(context, titleController: _titleController);
  bool _getScheduledValue(GlobalManageState state) {
    return (state.personalAlarmHourItems
        ?.contains(PersonalAlarmModel(isSelected: true)) ?? false) &&
        (state.personalAlarmMinutesItems
            ?.contains(PersonalAlarmModel(isSelected: true)) ?? false);
  }

  Future<void> _showTaskNotification() async {
    await _notificationManager.showNotification(
      title: "Hatırlatma!",
      body: "Bir Adet görevin var.",
      scheduled: true,
      hour: hour,
      minute: minute,
    );
  }

  Padding _addAlarmText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlySmall,
      child: Text(widget.isEdit ? editAlarmText : addAlarmText),
    );
  }

  Padding _categoryText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlySmall,
      child: Text(widget.isEdit ? editCategoryText : categoryText),
    );
  }

  TextFormField _titleTextFormField() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: widget.isEdit ? editTaskTitle : addTaskTitle,
      ),
      maxLength: 100,
    );
  }

  Padding _addTaskButton(BuildContext context) {
    return Padding(
      padding: context.padding.bottomOnlyNormal,
      child: BlocBuilder<GlobalManageCubit, GlobalManageState>(
        builder: (context, state) {
          return SizedBox(
            width: context.sized.dynamicWidth(0.6),
            height: context.sized.floatActionButtonSize,
            child: ElevatedButton(
              onPressed: widget.isEdit
                  ? () {
                      edit();
                      if(_getScheduledValue(state)){
                        _showTaskNotification();
                      }
                    }
                  : () {
                      add();
                      if(_getScheduledValue(state)){
                        _showTaskNotification();
                      }
                    },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      AppColor.aquaticCool.getColor()),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: context.border.largeBorderRadius))),
              child: Text(
                widget.isEdit ? editTaskText : addTaskText,
                style: context.general.textTheme.titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Text _addNewTaskText(BuildContext context) => Text(widget.isEdit ? editTheTaskText : addNewTaskText, style: context.general.textTheme.titleLarge);

  BlocBuilder<GlobalManageCubit, GlobalManageState> _addAlarm() {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
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
                        return BottomSheetAlarmButton(index: index, minOrHour: 24, onPressed: () {
                          context.read<GlobalManageCubit>().toggleAlarmHourItems(index);
                          setState(() {hour = index;});
                        },minOrHourItems: state.personalAlarmHourItems,);
                      },
                    )),
                Expanded(
                    child: ListView.builder(
                      itemCount:
                      state.personalAlarmMinutesItems?.length ?? 0,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return BottomSheetAlarmButton(
                          index: index,
                          minOrHour: 60,
                          onPressed: () {context.read<GlobalManageCubit>().toggleAlarmMinutesItem(index);
                          setState(() {minute = index;});},
                          minOrHourItems: state.personalAlarmMinutesItems,
                        );
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

//todo: bildirim kısmı açıldıgında açılsın kapatıldıgında kapatılsın!
