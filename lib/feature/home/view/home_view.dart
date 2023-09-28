import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import 'package:task_muse/product/global/cubit/global_manage_state.dart';
import 'package:task_muse/product/widget/is_visible_button.dart';

import '../../../core/const/colors.dart';
import '../../../core/widget/alert_dialog/main_alert_dialog.dart';
import '../../../core/widget/custom_image_container.dart';
import '../../../product/global/provider/global_manage_provider.dart';
import '../../../product/widget/text_with_space.dart';
import '../../../product/widget/to_do_card.dart';
import 'home_view_alert_dialog.dart';

part 'home_parts/part_of_body_pace_lvb.dart';
part 'home_parts/part_of_page_body_component.dart';
part 'home_parts/part_of_page_top_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocSelector<GlobalManageCubit,GlobalManageState,bool>(
        selector: (state) {
          return state.isAnyCardSwiped!;
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: state ? () {context.read<GlobalManageCubit>().makeIsSwipedFalse();} : null,
            child: Column(
              children: [
                _PageTopComponent(),
                _PageBodyComponent(),
              ],
            ),
          );
        },
      ),
    );
  }
}


