import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/tasks/view/tasks_page_view.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';

import '../../../core/const/colors.dart';
import '../../../core/widget/bottom_sheet/main_bottom_sheet.dart';
import '../../../product/global/cubit/global_manage_cubit.dart';
import '../../../product/global/provider/global_manage_provider.dart';
import 'bottom_nav_bar_view.dart';
import '../../home/view/home_view.dart';
import '../../home/view/home_view_bottom_sheet.dart';

part 'part_of_page_float_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();

  void _changePageViewPage(int index,BuildContext context){
    context.read<GlobalManageCubit>().makeIsSwipedFalse();
    pageController.animateToPage(index, duration: context.duration.durationNormal, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalManageProvider.globalManageCubit,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const _MainPageFloatActionButton(),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            TasksPageView(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          onTap: (int index) {
            _changePageViewPage(index, context);
          },
        ),
      ),
    );
  }
}

