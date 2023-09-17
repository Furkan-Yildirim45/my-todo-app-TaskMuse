import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/widget/alert_dialog/main_alert_dialog.dart';
import 'package:task_muse/core/widget/custom_animation_elev_button.dart';
import 'package:task_muse/core/widget/custom_elevated_button.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/global/cubit/global_manage_state.dart';
import 'package:task_muse/product/global/provider/global_manage_provider.dart';
import 'package:task_muse/product/widget/text_with_space.dart';
import 'package:task_muse/product/widget/to_do_card.dart';
import '../../../core/const/colors.dart';
import '../../../core/widget/bottom_sheet/main_bottom_sheet.dart';
import '../../../core/widget/custom_image_container.dart';
import 'main_page_alert_dialog.dart';
import 'main_page_bottom_sheet.dart';

part 'main_page_parts/part_of_bottom_nav_bar.dart';

part 'main_page_parts/part_of_page_top_component.dart';

part 'main_page_parts/part_of_page_body_component.dart';

part 'main_page_parts/part_of_page_float_button.dart';
part 'main_page_parts/part_of_body_pace_lvb.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final GlobalManageCubit _globalManageCubit;

  @override
  void initState() {
    super.initState();
    _globalManageCubit = GlobalManageCubit();
    _globalManageCubit.setItemsToTaskItems();
    GlobalManageProvider.init(_globalManageCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _globalManageCubit,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const _MainPageFloatActionButton(),
        body: SafeArea(
          child: BlocSelector<GlobalManageCubit,GlobalManageState,bool>(
            selector: (state) {
              return state.isAnyCardSwiped!;
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: state ? () {_globalManageCubit.makeIsSwipedFalse();} : null,
                child: Column(
                  children: [
                    _PageTopComponent(),
                    _PageBodyComponent(),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: const _BottomNavBar(),
      ),
    );
  }
}

