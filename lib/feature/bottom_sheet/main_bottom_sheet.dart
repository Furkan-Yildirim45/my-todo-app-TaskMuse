import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/icon_size.dart';
import 'package:task_muse/product/extension/context/size.dart';
import '../../core/const/colors.dart';

part 'part_of_header.dart';

mixin MainBottomSheet {
  Future<T?> showCustomMainBottomSheet<T extends Cubit>(
      {required BuildContext context, Widget? child, required T cubit}) async {
    BorderRadius generalModalBottomSheetBorderRadius =
    BorderRadius.vertical(
        top: Radius.circular(context.sized.dynamicHeigth(0.07)));
    return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColor.enoki.getColor(),
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: generalModalBottomSheetBorderRadius),
      builder: (context) {
        return BlocProvider<T>.value(
          value: cubit,
          child: _CustomMainBottomSheet(
            child: child,
          ),
        );
      },
    );
  }
}

class _CustomMainBottomSheet extends StatelessWidget {
  const _CustomMainBottomSheet({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeigth(0.85),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BaseSheetHeaderComponent(),
          Expanded(
            child: child ?? const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}


mixin _BaseSheetHeaderComponentUtility {
  final IconData iconArrowBack = Icons.arrow_back;
  final double dividerDefaultHeight = 5;
}