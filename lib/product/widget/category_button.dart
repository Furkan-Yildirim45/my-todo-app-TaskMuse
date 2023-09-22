import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';

import '../../core/const/colors.dart';
import '../../feature/home/model/personal_tag_model.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.categoryTitle,
    required this.index,
    this.personalTags, required this.blocBuilderContext,
  }) : super(key: key);
  final String? categoryTitle;
  final int index;
  final List<PersonalTagModel>? personalTags;
  final BuildContext blocBuilderContext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ButtonStyle(
          animationDuration: context.duration.durationNormal,
          backgroundColor: (personalTags?[index].isActive ?? false)
              ? MaterialStatePropertyAll((personalTags?[index].color) ?? AppColor.defaultColor.getColor())
              : const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.sized.dynamicHeigth(0.035)),
              side: BorderSide(color: personalTags?[index].color ?? AppColor.defaultColor.getColor(), width: 5),
            ),
          ),
        ),
        onPressed: (){blocBuilderContext.read<GlobalManageCubit>().toggleTag(index);},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sized.smallValue),
          child: Center(
              child: Text(categoryTitle ?? "", style: context.general.textTheme.titleMedium?.copyWith(color: Colors.black,),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
        ),
      ),
    );
  }
}
