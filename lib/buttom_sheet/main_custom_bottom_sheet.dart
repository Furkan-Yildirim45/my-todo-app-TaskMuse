import 'package:flutter/material.dart';
import 'package:task_muse/const/colors.dart';
import 'package:task_muse/extension/device_size.dart';

import '../core/custom_divider.dart';

mixin MainBottomSheet {
  Future<T?> showCustomMainBottomSheet<T>(
      {required BuildContext context, Widget? child}) async {
    const BorderRadius generalModalBottomSheetBorderRadius =
    BorderRadius.vertical(top: Radius.circular(12));
    return showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: ProjectColors().enoki,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BaseSheetHeaderComponent(),
        Expanded(
          child: child ?? const SizedBox.shrink(),
        )
      ],
    );
  }
}

class _BaseSheetHeaderComponent extends StatelessWidget
    with _BaseSheetHeaderComponentUtility {
  _BaseSheetHeaderComponent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: generalSize,
      child: Row(
        children: [
          InkWell(
              borderRadius: BorderRadius.circular(generalSize / 2),
              child: Container(
                  width: generalSize,
                  height: generalSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(generalSize / 2)),
                  child: Icon(
                    iconArrowBack,
                    color: Colors.black,
                  )),
              onTap: () {
                Navigator.of(context).pop<bool>(true);
              }),
          Expanded(
            child: CustomDivider(
              dividerHeight: dividerDefaultHeight,
              indent: context.getDeviceWidth(context) * 0.35,
              endIndent: context.getDeviceWidth(context) * 0.45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(dividerDefaultHeight / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

mixin _BaseSheetHeaderComponentUtility {
  final double generalSize = 40;
  final IconData iconArrowBack = Icons.arrow_back;
  final double dividerDefaultHeight = 5;
}