
part of"../main_page_bottom_sheet.dart";


class _TagsPlace extends StatefulWidget {
  const _TagsPlace();

  @override
  State<_TagsPlace> createState() => _TagsPlaceState();
}

class _TagsPlaceState extends State<_TagsPlace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyNormal,
      child: SizedBox(
        width: context.sized.width,
        height: context.sized.dynamicHeigth(0.17),
        child: GridView.builder(
          padding: context.padding.allNormal,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: context.sized.normalValue,
              crossAxisSpacing: context.sized.normalValue,
              childAspectRatio: context.sized.dynamicHeigth(0.078) / context.sized.dynamicHeigth(0.25)),
          itemCount: GeneralDatas.personalTags?.length ?? context.sized.kZero.toInt(),
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
