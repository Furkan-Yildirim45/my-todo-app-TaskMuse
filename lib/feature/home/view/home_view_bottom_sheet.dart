import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';

import '../../../product/global/cubit/global_manage_state.dart';
import '../../../product/widget/category_button.dart';

part 'bottom_sheet_parts/part_of_tags_place.dart';

class MainPageBottomSheet extends StatelessWidget with _BottomSheetUtility{
  MainPageBottomSheet({
    super.key,
  });

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _addNewTaskText(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleTextFormField(),
              _categoryText(context),
              const _TagsPlace(),
            ],
          ),
          const Spacer(),
          _addTaskButton(context)
        ],
      ),
    );
  }

  Padding _categoryText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyNormal,
      child: Text(categoryText),
    );
  }

  TextFormField _titleTextFormField() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: addTaskTitle,
      ),
      maxLength: 100,
    );
  }

  Padding _addTaskButton(BuildContext context) {
    return Padding(
      padding: context.padding.bottomOnlyNormal,
      child: SizedBox(
        width: context.sized.dynamicWidth(0.6),
        height: context.sized.floatActionButtonSize,
        child: ElevatedButton(
          onPressed: () {
            context.read<GlobalManageCubit>().bottomSheetAddTaskMethod(context,titleController: _titleController);
          },
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: context.border.largeBorderRadius))),
          child: Text(
            addTaskText,
            style: context.general.textTheme.titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Text _addNewTaskText(BuildContext context) => Text(addNewTaskText, style: context.general.textTheme.titleLarge);
}

mixin _BottomSheetUtility {
  final String addNewTaskText = "Add new task";
  final String addTaskText = "Add task";
  final String tampDateText = "Temp Date!";
  final String addTaskTitle = "Add Task Title";
  final String categoryText = "Category";
}
