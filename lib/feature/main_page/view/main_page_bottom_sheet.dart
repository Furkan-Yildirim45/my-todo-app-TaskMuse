import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import '../../../product/widget/category_button.dart';

part 'bottom_sheet_parts/part_of_choose_color.dart';
part 'bottom_sheet_parts/part_of_tags_place.dart';

class MainPageBottomSheet extends StatefulWidget {
  const MainPageBottomSheet({
    super.key,
  });

  @override
  State<MainPageBottomSheet> createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet>
    with _BottomSheetUtility {
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _addNewTaskText(context),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleTextFormField(),
                _descriptionTextFormField(),
                _categoryText(),
                const _TagsPlace(),
                _setColorText(context),
                const _ChooseColor(),
              ],
            ),
          ),
          const Spacer(),
          _addTaskButton(context)
        ],
      ),
    );
  }

  Padding _setColorText(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: Text(
        setColorText,
        style: context.general.textTheme.titleSmall,
      ),
    );
  }

  Padding _categoryText() {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: Text(categoryText),
    );
  }

  TextFormField _descriptionTextFormField() {
    return TextFormField(
      controller: _subtitleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: yourDescriptionText,
      ),
    );
  }

  TextFormField _titleTextFormField() {
    return TextFormField(
      controller: _titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: addTaskTitle,
      ),
      maxLength: 50,
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
            context.read<GlobalManageCubit>().bottomSheetAddTaskMethod(
                context,
                titleController: _titleController,
                subtitleController: _subtitleController);
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

  Text _addNewTaskText(BuildContext context) =>
      Text(addNewTaskText, style: context.general.textTheme.titleLarge);
}

mixin _BottomSheetUtility {
  final String addNewTaskText = "Add new task";
  final String addTaskText = "Add task";
  final String tampDateText = "Temp Date!";
  final String addTaskTitle = "Add Task Title";
  final String yourDescriptionText = "Description your task";
  final String categoryText = "Category";
  final String setColorText = "Set Color";
}

// baba chatoya bi entegrasyon seysi yaptırdım ona bi bak!