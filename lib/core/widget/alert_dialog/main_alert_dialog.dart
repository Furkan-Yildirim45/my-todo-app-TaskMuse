
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin MainAlertDialog{
  Future<T?> customAlertDialog<T extends Cubit>({required BuildContext context,Widget? child,
      required T cubit}){
    return showDialog<T>(
      context: context,
      builder: (context) {
        return BlocProvider<T>.value(
          value: cubit,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}