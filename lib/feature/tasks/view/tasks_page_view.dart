import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../product/model/task_model.dart';
import '../../../product/utility/hive_manager.dart';
import '../cubit/tasks_state.dart';

part 'parts/app_bar/part_of_app_bar_text_field.dart';

part 'parts/app_bar/part_of_search_place_button.dart';

class TasksPageView extends StatefulWidget {
  const TasksPageView({Key? key}) : super(key: key);

  @override
  State<TasksPageView> createState() => _TasksPageViewState();
}

class _TasksPageViewState extends State<TasksPageView> with _PageUtility {
  late List<TaskModel> taskItems = [];

  @override
  void initState() {
    super.initState();
    taskItems = context.read<TasksCubit>().getDefaultTaskItems() ?? [];
  }

  void findAndSetItems(String userSearchValue) {
    taskItems = TaskCacheManager.instance.getValues!
        .where((task) =>
            task.title.toLowerCase().contains(userSearchValue.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, stateBlocBuilder) {
          return BlocSelector<GlobalManageCubit, GlobalManageState, bool>(
            selector: (state) {
              return state.isAnyCardSwiped ?? false;
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: state ? () {context.read<GlobalManageCubit>().makeIsSwipedFalse();} : null,
                child: Scaffold(
                  appBar: _appBar(stateBlocBuilder, context),
                  body: Padding(
                    padding: EdgeInsets.all(context.sized.mediumValue),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: taskItems.length,
                            itemBuilder: (context, index) {
                              return ToDoCard(   ///todo bu kısımda birbirine bastıgımda biri aktifken değişme olmuyor onu da ayarlıcam!
                                  index: index, taskItems: taskItems);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar _appBar(TasksState state, BuildContext context) {
    return AppBar(
              backgroundColor: AppColor.aquaticCool.getColor(),
            centerTitle: (state.isSearchActive ?? false) ? false : true,
            title: (state.isSearchActive ?? false)
                ? _AppBarTextField(onChanged: (value) {findAndSetItems(value);},)
                : Text(appBarTitle),
            toolbarHeight: context.sized.floatActionButtonSize,
            actions: (state.isSearchActive ?? false) ? null : [_searchButtonAppBar(context),],
          );
  }
}

mixin _PageUtility on State<TasksPageView> {
  double get searchButtonSize => context.sized.dynamicHeigth(0.07);

  String get appBarTitle => 'Your Task by day';

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
        child: const Icon(Icons.search_outlined),
      ),
    );
  }
}

///todo: en son todoCard içi farklılıkları yapıcam önce bu üsttekiler!