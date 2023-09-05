
part of"../main_page_bottom_sheet.dart";

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
      var stickBarOffsetSliderValue = context.sized.dynamicHeigth(0.07745);
      visibleStartIndex = (_scrollController.offset / stickBarOffsetSliderValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: context.padding.topOnlyNormal,
          child: SizedBox(
            height: context.sized.floatActionButtonSize,
            width: context.sized.width,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: totalBoxCount.toInt(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _ColorsOfChooseColorCircleWidget(index: index, totalBoxCount: totalBoxCount.toInt());
              },
            ),
          ),
        ),
        _stickBarOfChooseColor(context),
      ],
    );
  }

  Container _stickBarOfChooseColor(BuildContext context) {
    return Container(
        margin: context.padding.topOnlyNormal,
        color: Colors.black12,
        width: context.sized.width,
        height: context.sized.smallValue,
        child: Stack(
          children: [
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor:
              (visibleStartIndex + initVisibleCount) / totalBoxCount,
              child: Container(
                height: context.sized.smallValue,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      );
  }
}

class _ColorsOfChooseColorCircleWidget extends StatefulWidget {
  const _ColorsOfChooseColorCircleWidget({Key? key, required this.index, required this.totalBoxCount}) : super(key: key);
  final int index;
  final int totalBoxCount;
  @override
  State<_ColorsOfChooseColorCircleWidget> createState() => _ColorsOfChooseColorCircleWidgetState();
}

class _ColorsOfChooseColorCircleWidgetState extends State<_ColorsOfChooseColorCircleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.index == (widget.totalBoxCount - 1)
          ? EdgeInsets.zero
          : context.padding.rightOnlyNormal,
      child: SizedBox(
        width: context.sized.floatActionButtonSize,
        height: context.sized.floatActionButtonSize,
        child: GestureDetector(
          onTap: () {
            _toggleColor(widget.index);
          },
          child: Container(
            width: context.sized.floatActionButtonSize,
            height: context.sized.floatActionButtonSize,
            decoration: BoxDecoration(
                border: Border.all(
                    color: GeneralDatas.personalColor!
                        .elementAt(widget.index)
                        .isActive
                        ? Colors.blue
                        : Colors.white,
                    width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.sized.floatActionButtonSize / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: context.sized.kZero,
                    spreadRadius: 0.1,
                  )
                ]),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: context.sized.mediumValue,
                    height: context.sized.mediumValue,
                    decoration: BoxDecoration(
                        color: GeneralDatas
                            .personalColor![widget.index].color,
                        borderRadius: context.border.smallBorderRadius)),
              ],
            ),
          ),
        ),
      ),
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



/*
_scrollController değişkeni, ScrollController'ın tanımlandığı ve başlatıldığı yerdir. Bu controller, ListView'ın kaydırılmasını ve görünen öğelerin
indeksini izlemek için kullanılır.

_scrollController.offset ifadesi, ListView'in şu anki kaydırma pozisyonunu temsil eder.
(_scrollController.offset / 56) ifadesi, ListView'in kaç piksel kaydırıldığını kutu boyutuna (56 piksel) bölerek, görünen öğelerin ilk indeksini hesaplar.
*/
