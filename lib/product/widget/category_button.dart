import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/core/widget/info_box/info_box.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';

import '../../core/const/colors.dart';
import '../../feature/home/model/personal_tag_model.dart';

class CategoryButton extends StatelessWidget with MainInfoBox{
  CategoryButton({
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
        key: GlobalKey(),
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
        onLongPress: () {
          showOverlayEntry(
              context: context,
              widget: _customOverlayEntry(
                  context: context,
                  contentText: personalTags?[index].tag ?? ""));
        },
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
  OverlayEntry _customOverlayEntry({required BuildContext context,required String contentText}){
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: offset.dy - renderBox.size.height / 1.7,
          left: offset.dx,
          child: Container(
            padding: context.padding.dynamicSymmetric(vertical: 0.005, horizontal: 0.01),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(context.sized.smallValue),
            ),
            child: Text(
              contentText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
