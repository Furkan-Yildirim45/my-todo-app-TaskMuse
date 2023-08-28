import 'package:flutter/material.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/feature/main_page/model/task_model.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/utility/hive_manager.dart';

import '../../../product/widget/category_button.dart';

class MainPageBottomSheet extends StatefulWidget {
  const MainPageBottomSheet({
    super.key,
  });

  @override
  State<MainPageBottomSheet> createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Text("Add new task", style: context.general.textTheme.titleLarge),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Add Task Title",
                  ),
                  maxLength: 50,
                ),
                TextFormField(
                  controller: _subTitleController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Description your task",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text('Category'),
                ),
                const _TagsPlace(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Set Color',
                    style: context.general.textTheme.titleSmall,
                  ),
                ),
                const _ChooseColor(),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: SizedBox(
              width: context.sized.dynamicWidth(0.6),
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isNotEmpty &&
                      _subTitleController.text.isNotEmpty) {
                    await TaskCacheManager.instance.addItem(TaskModel(
                      title: _titleController.text,
                      subTitle: _subTitleController.text,
                      color: TaskModel.colorToString(_selectedColor() ?? Colors.white),
                      date: "temp date!",
                    )).whenComplete(() {
                      Navigator.of(context).pop<bool>(true);
                    });
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Text(
                  'Add Task',
                  style: context.general.textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color? _selectedColor(){
    if(GeneralDatas.personalColor?.isNotEmpty ?? false){
      for(var value in GeneralDatas.personalColor!){
        if(value.isActive) return value.color;
      }
    }
    return null;
  }
}

class _ChooseColor extends StatefulWidget {
  const _ChooseColor();

  @override
  State<_ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<_ChooseColor> {
  double visibleStartIndex = 0;
  double totalBoxCount = 10;
  late final ScrollController _scrollController;
  final int initVisibleCount = 5;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      visibleStartIndex = (_scrollController.offset / 55);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 56,
            width: context.sized.width,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: totalBoxCount.toInt(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: index == (totalBoxCount - 1)
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: GestureDetector(
                      onTap: () {
                        _toggleColor(index);
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: GeneralDatas.personalColor!
                                        .elementAt(index)
                                        .isActive
                                    ? Colors.blue
                                    : Colors.white,
                                width: 2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: 0.1,
                              )
                            ]),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: GeneralDatas
                                        .personalColor![index].color,
                                    borderRadius: BorderRadius.circular(8))),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          color: Colors.black12,
          width: MediaQuery.of(context).size.width,
          height: 5,
          child: Stack(
            children: [
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor:
                    (visibleStartIndex + initVisibleCount) / totalBoxCount,
                child: Container(
                  height: 5,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _toggleColor(int index) {
    if (GeneralDatas.personalColor![index].isActive == false) {
      GeneralDatas.personalColor![index].isActive = true;
      for (var tag in GeneralDatas.personalColor!) {
        if (GeneralDatas.personalColor?.indexOf(tag) != index) {
          tag.isActive = false;
        }
      }
    } else if (GeneralDatas.personalColor![index].isActive == true) {
      GeneralDatas.personalColor![index].isActive = true;
      for (var tag in GeneralDatas.personalColor!) {
        if (GeneralDatas.personalColor!.indexOf(tag) != index) {
          tag.isActive = false;
        }
      }
    }
    setState(() {});
  }
}

class _TagsPlace extends StatefulWidget {
  const _TagsPlace();

  @override
  State<_TagsPlace> createState() => _TagsPlaceState();
}

class _TagsPlaceState extends State<_TagsPlace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: context.sized.dynamicHeigth(0.078) / 180),
          itemCount: GeneralDatas.personalTags?.length ?? 0,
          itemBuilder: (context, index) => CategoryButton(
            categoryTitle: GeneralDatas.personalTags?.elementAt(index).tag,
            index: index,
            onPressed: () {
              _toggleTag(index);
            },
          ),
        ),
      ),
    );
  }

  void _toggleTag(int index) {
    if (GeneralDatas.personalTags![index].isActive == false) {
      GeneralDatas.personalTags![index].isActive = true;
      for (var tag in GeneralDatas.personalTags!) {
        if (GeneralDatas.personalTags?.indexOf(tag) != index) {
          tag.isActive = false;
        }
      }
    } else if (GeneralDatas.personalTags![index].isActive == true) {
      GeneralDatas.personalTags![index].isActive = true;
      for (var tag in GeneralDatas.personalTags!) {
        if (GeneralDatas.personalTags!.indexOf(tag) != index) {
          tag.isActive = false;
        }
      }
    }
    setState(() {});
  }
}

/*
_scrollController değişkeni, ScrollController'ın tanımlandığı ve başlatıldığı yerdir. Bu controller, ListView'ın kaydırılmasını ve görünen öğelerin
indeksini izlemek için kullanılır.

_scrollController.offset ifadesi, ListView'in şu anki kaydırma pozisyonunu temsil eder.
(_scrollController.offset / 56) ifadesi, ListView'in kaç piksel kaydırıldığını kutu boyutuna (56 piksel) bölerek, görünen öğelerin ilk indeksini hesaplar.
*/
