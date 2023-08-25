import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/size.dart';
import '../../core/const/colors.dart';
part 'part_of_header.dart';

mixin MainBottomSheet {
  Future<T?> showCustomMainBottomSheet<T>(
      {required BuildContext context, Widget? child}) async {
    const BorderRadius generalModalBottomSheetBorderRadius =
    BorderRadius.vertical(top: Radius.circular(50));
    return showModalBottomSheet(
       useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColor.enoki.getColor(),
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: generalModalBottomSheetBorderRadius),
      builder: (context) {
        return _CustomMainBottomSheet(
          child: child,
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
  final double generalSize = 56;
  final IconData iconArrowBack = Icons.arrow_back;
  final double dividerDefaultHeight = 5;
}