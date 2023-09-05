

import 'package:flutter/material.dart';

import 'bottom_sheet_component.dart';
import 'bottom_sheet_ui_test.dart';

mixin BottomSheetMixin on State<BottomSheetUiTest>{

  ValueNotifier<String> titleNotifier = ValueNotifier<String>("");

  Future<void> showModelBottomSheetWithMixin() async {
    final response = await BottomSheetComponent.show(context, /*(value) {
      titleNotifier.value = value;
    }*/);
    /*showModalBottomSheet(context: context, builder: (context) {
      return BottomSheetComponent(
        onValueSelected: (value) {
          titleNotifier.value = value; //bunu da buraya veriyosun abi!
        },
      );
    },);*/

    if(response == null )return;
    titleNotifier.value = response.value;
  }
}

