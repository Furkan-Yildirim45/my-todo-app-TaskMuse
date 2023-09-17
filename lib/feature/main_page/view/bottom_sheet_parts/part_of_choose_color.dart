
part of"../main_page_bottom_sheet.dart";

class _ChooseColor extends StatefulWidget {
  const _ChooseColor();

  @override
  State<_ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<_ChooseColor> {
  late final ScrollController _scrollController;
  double progressValue = 0;
  int totalBoxCount = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double scrollPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double progress = scrollPosition / maxScrollExtent;
    setState(() {
      progressValue = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _colorButtonListView(context),
        _stickBarOfChooseColor(context),
      ],
    );
  }

  Padding _colorButtonListView(BuildContext context) {
    return Padding(
        padding: context.padding.topOnlyNormal,
        child: SizedBox(
          height: context.sized.floatActionButtonSize,
          width: context.sized.width,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: totalBoxCount.toInt(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
            return _ColorsOfChooseColorCircleWidget(
              index: index,
              totalBoxCount: totalBoxCount.toInt(),
              onTap: () {
                _toggleColor(index);
              },
            );
          },
          ),
        ),
      );
  }

  Padding _stickBarOfChooseColor(BuildContext context) {
    return Padding(
        padding: context.padding.topOnlyNormal,
        child: LinearProgressIndicator(
          minHeight: context.sized.smallValue,
          backgroundColor: Colors.black12,
          value: progressValue,
          color: Colors.blue,
        ),
      );
  }

  void _toggleColor(int index) {
    setState(() {
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
    });
  }
}

class _ColorsOfChooseColorCircleWidget extends StatefulWidget {
  const _ColorsOfChooseColorCircleWidget({Key? key, required this.index, required this.totalBoxCount, required this.onTap}) : super(key: key);
  final int index;
  final int totalBoxCount;
  final Function() onTap;
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
        child: InkWell(
          borderRadius: BorderRadius.circular(context.sized.floatActionButtonSize / 2),
          onTap: widget.onTap,
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
}



/*
_scrollController değişkeni, ScrollController'ın tanımlandığı ve başlatıldığı yerdir. Bu controller, ListView'ın kaydırılmasını ve görünen öğelerin
indeksini izlemek için kullanılır.

_scrollController.offset ifadesi, ListView'in şu anki kaydırma pozisyonunu temsil eder.
(_scrollController.offset / 56) ifadesi, ListView'in kaç piksel kaydırıldığını kutu boyutuna (56 piksel) bölerek, görünen öğelerin ilk indeksini hesaplar.
*/
