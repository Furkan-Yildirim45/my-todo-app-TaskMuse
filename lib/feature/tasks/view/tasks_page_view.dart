import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/widget/bottom_sheet/main_bottom_sheet.dart';
import 'package:task_muse/core/widget/custom_elevated_button.dart';
import 'package:task_muse/feature/tasks/cubit/tasks_cubit.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/global/cubit/global_manage_state.dart';
import 'package:task_muse/product/widget/to_do_card.dart';
import '../../../core/const/colors.dart';
import '../../../core/widget/alert_dialog/main_alert_dialog.dart';
import '../../../product/global/provider/global_manage_provider.dart';
import '../../../product/model/task_model.dart';
import '../../../product/utility/hive_manager.dart';
import '../../../product/widget/is_visible_button.dart';
import '../../home/view/home_view_alert_dialog.dart';
import '../../home/view/home_view_bottom_sheet.dart';
import '../cubit/tasks_state.dart';

part 'parts/app_bar/part_of_app_bar_text_field.dart';

part 'parts/app_bar/part_of_search_place_button.dart';

class TasksPageView extends StatefulWidget {
  const TasksPageView({Key? key}) : super(key: key);

  @override
  State<TasksPageView> createState() => _TasksPageViewState();
}

class _TasksPageViewState extends State<TasksPageView>
    with _PageUtility, MainAlertDialog,MainBottomSheet {
  late List<TaskModel> taskItems = [];
  late final TasksCubit _tasksCubit;
  @override
  void initState() {
    super.initState();
    _tasksCubit = TasksCubit();
    getItemsFromGlobalCubit();
  }

  void getItemsFromGlobalCubit() {
    if (TaskCacheManager.instance.getValues?.isNotEmpty ?? false) {
      taskItems = TaskCacheManager.instance.getValues!;
    }
  }

  void findAndSetItems(String userSearchValue) {
    if (TaskCacheManager.instance.getValues?.isNotEmpty ?? false) {
      taskItems = TaskCacheManager.instance.getValues!
          .where((task) =>
              task.title.toLowerCase().contains(userSearchValue.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, stateBlocBuilder) {
          return BlocListener<GlobalManageCubit, GlobalManageState>(
            listener: (context, state) {
              taskItems = state.taskItems ?? [];
            },
            child: BlocBuilder<GlobalManageCubit, GlobalManageState>(
              builder: (context, stateGlobalBuilder) {
                return GestureDetector(
                  onTap: (stateGlobalBuilder.isAnyCardSwiped ?? false)
                      ? () {context.read<GlobalManageCubit>().makeIsSwipedFalse();}
                      : null,
                  child: Scaffold(
                    appBar: _appBar(stateBlocBuilder, context),
                    body: (stateGlobalBuilder.isLoading ?? false)
                        ? const LinearProgressIndicator()
                        : (stateGlobalBuilder.taskItems?.isNotEmpty ?? false)
                            ? _bodyPart(context)
                            : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Padding _bodyPart(BuildContext context) {
    return Padding(
                              padding:
                                  EdgeInsets.all(context.sized.mediumValue),
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: addedCardHeight(context) * (taskItems.length),
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      reverse: true,
                                      itemCount: taskItems.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              _todoCardPlace(
                                                  context, index, taskItems),
                                              _placeOfIsVisibleButtons(
                                                  context, index),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
  }

  Row _placeOfIsVisibleButtons(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IsVisibleButton(
            context: context,
            state: GlobalManageProvider.globalManageCubit.state,
            backgroundColor: const Color(0xFFc2dbff),
            onPressed: () {
              showCustomMainBottomSheet(
                  child: const HomePageBottomSheet(isEdit: true),
                  context: context,
                  cubit: GlobalManageProvider.globalManageCubit);
            },
            index: index,
            iconColor: Colors.blue,
            icon: Icons.edit),
        IsVisibleButton(
          index: index,
          context: context,
          state: GlobalManageProvider.globalManageCubit.state,
          backgroundColor: const Color(0xffffcfcf),
          onPressed: () {
            customAlertDialog(
              context: context,
              cubit: GlobalManageProvider.globalManageCubit,
              child: AreYouSureWantToDelete(index: index),
            );
          },
          iconColor: Colors.red,
          icon: Icons.restore_from_trash_outlined,
        )
      ],
    );
  }

  AppBar _appBar(TasksState state, BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.aquaticCool.getColor(),
      centerTitle: (state.isSearchActive ?? false) ? false : true,
      title: (state.isSearchActive ?? false)
          ? _AppBarTextField(
              onChanged: (value) {
                findAndSetItems(value);
              },
            )
          : Text(appBarTitle,style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
      toolbarHeight: context.sized.floatActionButtonSize,
      actions: (state.isSearchActive ?? false)
          ? null
          : [
              _searchButtonAppBar(context),
            ],
    );
  }
}

mixin _PageUtility on State<TasksPageView> {
  double addedCardHeight(BuildContext context) =>
      (context.sized.dynamicHeigth(0.115));

  double get searchButtonSize => context.sized.dynamicHeigth(0.07);

  String get appBarTitle => 'Your Task for day';

  EdgeInsets get searchBarMargin =>
      context.padding.dynamicSymmetric(vertical: 0.005, horizontal: 0.005);

  Container _searchButtonAppBar(BuildContext context) {
    return Container(
      margin: searchBarMargin,
      child: CustomElevatedButton(
        backgroundColor: AppColor.aquaticCool.getColor(),
        elevation: context.sized.kZero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(searchButtonSize / 2)),
        width: searchButtonSize,
        height: searchButtonSize,
        onPressed: () {
          context.read<TasksCubit>().changeIsSearchActive();
        },
        child: const Icon(Icons.search_outlined,color: Colors.white,),
      ),
    );
  }

  SizedBox _todoCardPlace(
      BuildContext context, int index, List<TaskModel> taskItems) {
    return SizedBox(
      width: (context.sized.width - context.sized.mediumValue * 2),
      child: ToDoCard(
        isTaskPageActive: true,
        index: index,
        taskItems: taskItems,
      ),
    );
  }
}
