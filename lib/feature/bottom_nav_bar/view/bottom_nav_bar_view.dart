import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/size.dart';

import '../../../core/const/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.onTap}) : super(key: key);
  final void Function(int index) onTap;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      onTap: onTap,
      curveSize: context.sized.kZero,
      top: context.sized.kZero,
      initialActiveIndex: BottomNavItems.home.index,
      backgroundColor: Colors.white,
      activeColor: AppColor.aquaticCool.getColor(),
      color: Colors.grey,
      items: [
        TabItem(
            icon: Icons.home_outlined,
            title: BottomNavItems.home.setBottomNavItemsName(),
        ),
        TabItem(
            icon: Icons.assignment,
            title: BottomNavItems.tasks.setBottomNavItemsName(),
        ),
      ],
    );
  }
}

enum BottomNavItems{
  home,tasks
}

extension _BottomNavItemsExtension on BottomNavItems{
  String setBottomNavItemsName(){
    String enumValue = toString().split(".").last;
    String firstLetter = enumValue[0].toUpperCase();
    String restOfString = enumValue.substring(1);
    return "$firstLetter$restOfString";
  }
}