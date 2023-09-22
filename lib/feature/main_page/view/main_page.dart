import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/tasks/view/tasks_page_view.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';

import '../../../core/const/colors.dart';
import '../../../core/widget/bottom_sheet/main_bottom_sheet.dart';
import '../../../product/global/cubit/global_manage_cubit.dart';
import '../../../product/global/provider/global_manage_provider.dart';
import '../../bottom_nav_bar/view/bottom_nav_bar_view.dart';
import '../../home/view/home_view.dart';
import '../../home/view/home_view_bottom_sheet.dart';

part 'part_of_page_float_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalManageProvider.globalManageCubit,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const _MainPageFloatActionButton(),
        body: PageView(
          children: const [
            HomeView(),
            TasksPageView(),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

///todo: ortak bottomnavbar için abi burda pageview yapıyorum!