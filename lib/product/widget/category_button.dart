import 'package:flutter/material.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/product/extension/context/duration.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key, required this.categoryTitle, required this.index, required this.onPressed}) : super(key: key);
  final String? categoryTitle;
  final int index;
  final void Function() onPressed;
  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        animationDuration: context.duration.durationNormal,
        backgroundColor: MaterialStatePropertyAll(GeneralDatas.personalTags![widget.index].isActive ? Colors.blue : Colors.grey,),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(context.sized.dynamicHeigth(0.035)),
        )),
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
            child: Text(
          widget.categoryTitle ?? "",
          style: context.general.textTheme.titleMedium
              ?.copyWith(color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,
        )),
      ),
    );
  }
}
