import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/feature/main_page/cubit/main_page_cubit.dart';
import 'package:task_muse/feature/main_page/cubit/main_page_state.dart';
import 'package:task_muse/main.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/model/task_model.dart';
import 'package:task_muse/product/widget/text_with_space.dart';
import 'package:task_muse/product/widget/to_do_card.dart';
import '../../../core/const/colors.dart';
import '../../../core/widget/custom_image_container.dart';
import '../../bottom_sheet/main_bottom_sheet.dart';
import 'main_page_bottom_sheet.dart';

part 'main_page_parts/part_of_bottom_nav_bar.dart';

part 'main_page_parts/part_of_page_top_component.dart';

part 'main_page_parts/part_of_page_body_component.dart';

part 'main_page_parts/part_of_page_float_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageCubit(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const _MainPageFloatActionButton(),
        body: SafeArea(
          child: Column(
            children: [
              _PageTopComponent(),
              const _PageBodyComponent(),
            ],
          ),
        ),
        bottomNavigationBar: const _BottomNavBar(),
      ),
    );
  }
}

