part of "../home_view.dart";

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
                                IsVisibleButton(
                                    context: context,
                                    state: state,
                                    backgroundColor: const Color(0xFFc2dbff),
                                    onPressed: () {

                                    },
                                    index: index,
                                    iconColor: Colors.blue,
                                    icon: Icons.edit
                                ),
                                IsVisibleButton(
                                  index: index,
                                  context: context,
                                  state: state,
                                  backgroundColor: const Color(0xffffcfcf),
                                  onPressed: () {
                                    customAlertDialog(
                                      context: context,
                                      cubit: GlobalManageProvider
                                          .globalManageCubit,
                                      child:
                                      AreYouSureWantToDelete(index: index),
                                    );
                                  },
                                  iconColor: Colors.red,
                                  icon: Icons.restore_from_trash_outlined,
                                )
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

  SizedBox _todoCardPlace(BuildContext context, int index, GlobalManageState state){
    return SizedBox(
      width: (context.sized.width - context.sized.mediumValue * 2),
      child: ToDoCard(
        isTaskPageActive: false,
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
