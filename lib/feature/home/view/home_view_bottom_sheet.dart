import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_muse/core/const/colors.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/utility/main_alarm.dart';

import '../../../product/global/cubit/global_manage_state.dart';
import '../../../product/widget/alarm_button.dart';
import '../../../product/widget/category_button.dart';

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
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late final ScheduledOrNowNotificationTrigger _notificationTrigger;
  @override
  void initState() {
    super.initState();
    context.read<GlobalManageCubit>().setDefaultAlarmMinuteItemsValue();
    context.read<GlobalManageCubit>().setDefaultAlarmHourItemsValue();
    _scrollController = ScrollController();
    _titleController = TextEditingController();
    _initAlarmElements();
  }

  void _initAlarmElements(){
    checkAndRequestPermission();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _notificationTrigger = ScheduledOrNowNotificationTrigger(_flutterLocalNotificationsPlugin);
  }

  Future<void> checkAndRequestPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted || status.isLimited) {
      // İzin verildi veya sınırlı izin varsa işlem yapabilirsiniz.
    } else {
      // İzin alınmamış veya reddedilmişse izin iste.
      final result = await Permission.notification.request();
      if (result.isGranted) {
        // İzin verildi, bu izni sakla.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('notificationPermission', true);
      }
    }
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
          _addTaskButton(
              context: context,
              onPressed: widget.isEdit
                  ? () {
                      edit();
                      _notificationTrigger.showNotification();
                    }
                  : () {
                      add();
                      _notificationTrigger.showNotification();
                    }),
        ],
      ),
    );
  }
  void edit() => context.read<GlobalManageCubit>().bottomSheetEditTaskMethod(context, titleController: _titleController);
  void add() => context.read<GlobalManageCubit>().bottomSheetAddTaskMethod(context, titleController: _titleController);
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

  late final ScrollController _scrollController;
  late final TextEditingController _titleController;
  int? hour = 0;
  int? minute = 0;

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

  Padding _addTaskButton({required BuildContext context, required void Function() onPressed}) {
    return Padding(
      padding: context.padding.bottomOnlyNormal,
      child: SizedBox(
        width: context.sized.dynamicWidth(0.6),
        height: context.sized.floatActionButtonSize,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColor.aquaticCool.getColor()),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: context.border.largeBorderRadius))),
          child: Text(
            widget.isEdit ? editTaskText : addTaskText,
            style: context.general.textTheme.titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
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
                          onPressed: () {context.read<GlobalManageCubit>().toggleAlarmMinutesItem(index);},
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

