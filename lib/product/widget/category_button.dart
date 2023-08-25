import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*width: 150,
      height: context.sized.dynamicHeigth(0.07),*/
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(context.sized.dynamicHeigth(0.035)),
          border: Border.all(width: 1,color: Colors.blue)
      ),
      child: Center(
          child: Text(
        'Adventure',
        style: context.general.textTheme.titleMedium
            ?.copyWith(color: Colors.white),
      )),
    );
  }
}
