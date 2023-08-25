import 'package:flutter/material.dart';
import 'package:task_muse/core/general_datas.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';

import '../../../product/widget/category_button.dart';

class MainPageBottomSheet extends StatefulWidget {
  const MainPageBottomSheet({
    super.key,
  });

  @override
  State<MainPageBottomSheet> createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet> {
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
  void _scrollListener(){
    setState(() {
      visibleStartIndex = (_scrollController.offset / 56);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Text("Add new task",style: context.general.textTheme.titleLarge),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Add Task Title",
                  ),
                  maxLength: 50,
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "Description your task",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text('Category'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,childAspectRatio: context.sized.dynamicHeigth(0.078) / 180),
                      itemCount: 10,
                      itemBuilder: (context, index) =>
                      const CategoryButton(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text('Set Priority',style: context.general.textTheme.titleSmall,),
                ),
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
                          padding: index == (totalBoxCount - 1) ? EdgeInsets.zero : const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                              boxShadow: const [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0,
                                spreadRadius: 0.1,
                              )]
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(width: 16,height: 16,decoration: BoxDecoration(
                                    color: GeneralDatas.selectableColors[index],
                                    borderRadius: BorderRadius.circular(8)
                                )),
                              ],
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
                        widthFactor: (visibleStartIndex + initVisibleCount) / totalBoxCount,
                        child: Container(
                          height: 5,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

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
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Text('Add Task',style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*
_scrollController değişkeni, ScrollController'ın tanımlandığı ve başlatıldığı yerdir. Bu controller, ListView'ın kaydırılmasını ve görünen öğelerin
indeksini izlemek için kullanılır.

_scrollController.offset ifadesi, ListView'in şu anki kaydırma pozisyonunu temsil eder.
(_scrollController.offset / 56) ifadesi, ListView'in kaç piksel kaydırıldığını kutu boyutuna (56 piksel) bölerek, görünen öğelerin ilk indeksini hesaplar.
*/
