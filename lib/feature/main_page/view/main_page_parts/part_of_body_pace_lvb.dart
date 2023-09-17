part of "../main_page_view.dart";

class _BodyPlaceListViewBuilder extends StatelessWidget
    with _BodyPlaceLVBUtility,MainAlertDialog{
  const _BodyPlaceListViewBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalManageCubit, GlobalManageState>(
      builder: (context, state) {
        return (state.isLoading ?? false) //ekranı güncellemek istiyorsan isLoading gibi load işlemi şart!
            ? const CircularProgressIndicator()
            : Padding(
              padding: context.padding.topOnlyNormal,
              child: SizedBox(
          height: addedCardHeight(context) * (state.taskItems?.length ?? context.sized.kZero.toInt()),
          child: ListView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.taskItems?.length ?? context.sized.kZero.toInt(),
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      _todoCardPlace(context, index, state),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _inVisibleButton(
                              context: context,
                              state: state,
                              backgroundColor: const Color(0xFFc2dbff),
                              onPressed: () {},
                              index: index,
                              iconColor: Colors.blue,
                              icon: Icons.edit),
                          _inVisibleButton(index: index, context: context, state: state, backgroundColor: const Color(0xffffcfcf), onPressed: () {
                            customAlertDialog(
                              context: context,
                              cubit: GlobalManageProvider.globalManageCubit, child: AreYouSureWantToDelete(index: index),);},
                            iconColor: Colors.red,
                            icon: Icons.restore_from_trash_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
          ),
        ),
        );
      },
    );
  }

  CustomAnimationElevatedButton _inVisibleButton(
      {required BuildContext context,
        required Color iconColor,
        required IconData icon,
      required GlobalManageState state,
        required Color backgroundColor,
        required void Function() onPressed,
      required int index}) {
    var containerSize = (state.taskItems?[index].isSwiped ?? false) ? context.sized.middleButtonSize : context.sized.kZero;
    double iconSize = (state.taskItems?[index].isSwiped ?? false) ? context.iconSize.normal : 0;
    return CustomAnimationElevatedButton(
      containerColor: backgroundColor,
      containerBorderRadius: BorderRadius.circular(context.sized.middleButtonSize / 2),
      containerHeigth: containerSize,
      containerWidth: containerSize,
      onPressed: onPressed,
      containerMargin: EdgeInsets.only(bottom: context.sized.normalValue,left: context.sized.normalValue),
      containerDuration: context.duration.durationFast,
      buttonElevation: context.sized.kZero,
      buttonPadding: context.padding.kZeroPadding,
      buttonBackgroundColor: Colors.transparent,
      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.sized.middleButtonSize / 2)),
      child: Icon(icon,color: iconColor,size: iconSize,)
    );
  }

  SizedBox _todoCardPlace(BuildContext context, int index, GlobalManageState state){
    return SizedBox(
      width: (context.sized.width - context.sized.mediumValue * 2),
      child: ToDoCard(
        index: index,
        taskItems: state.taskItems,
      ),
    );
  }
}

mixin _BodyPlaceLVBUtility {
  double addedCardHeight(BuildContext context) =>
      (context.sized.dynamicHeigth(0.115));
}
