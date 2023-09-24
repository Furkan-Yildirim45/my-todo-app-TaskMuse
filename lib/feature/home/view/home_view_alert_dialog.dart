import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';

import '../../../core/widget/custom_elevated_button.dart';
import '../../../product/global/cubit/global_manage_cubit.dart';

class AreYouSureWantToDelete extends StatelessWidget with _AlertDialogUtility{
  AreYouSureWantToDelete({
    super.key, required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
      contentPadding: context.padding.dynamicSymmetric(vertical: 0.03, horizontal: 0.06),
      content: Text(contentTitle, textAlign: TextAlign.center),
      shape: RoundedRectangleBorder(borderRadius: context.border.largeBorderRadius),
      icon: _warningImage(context),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(title),
      actions: [
        CustomElevatedButton(
          onPressed: () {
            context.route.pop();
          },
          width: buttonWidth(context),
          height: buttonHeigth(context),
          shape: buttonShapeValue(context),
          backgroundColor: Colors.red,
          child: Text(buttonCancelTitle),
        ),
        CustomElevatedButton(
          onPressed: () {
            context.read<GlobalManageCubit>().deleteTaskItem(context: context,index: index);
          },
          width: buttonWidth(context),
          height: buttonHeigth(context),
          shape: buttonShapeValue(context),
          backgroundColor: Colors.green,
          child: Text(buttonOkTitle),
        ),
      ],
    );
  }

  Container _warningImage(BuildContext context) {
    return Container(
        width: context.sized.largeValue,
        height: context.sized.largeValue,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(alertDialogOrangeWarningImage))));
  }
}

mixin _AlertDialogUtility{
  final String contentTitle = 'this item will be delete immediately';
  final String title = 'Are you sure want to delete?';
  final String buttonCancelTitle = 'Cancel';
  final String buttonOkTitle = 'Ok';
  final String alertDialogOrangeWarningImage = "assets/images/warning.png";

  double buttonWidth(BuildContext context) => context.sized.dynamicHeigth(0.15);
  double buttonHeigth(BuildContext context) => context.sized.dynamicHeigth(0.06);
  RoundedRectangleBorder buttonShapeValue(BuildContext context) => RoundedRectangleBorder(borderRadius: context.border.smallBorderRadius);

}