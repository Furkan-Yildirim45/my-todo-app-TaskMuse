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
            : SizedBox(
          height: addedCardHeight(context) * (state.taskItems?.length ?? context.sized.kZero.toInt()),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.taskItems?.length ?? context.sized.kZero.toInt(),
            itemBuilder: (context, index) {
              return SizedBox(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    _todoCardPlace(context, index, state),
                    _trashButton(state, index, context),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  SizedBox _todoCardPlace(BuildContext context, int index, GlobalManageState state){
    return SizedBox(
                          width: (context.sized.width -
                              context.sized.mediumValue * 2),
                          child: ToDoCard(
                            index: index,
                            taskItems: state.taskItems,
                          ),
                        );
  }

  AnimatedContainer _trashButton(
      GlobalManageState state, int index, BuildContext context) {
    var mainMargin = ((state.taskItems?.length ?? 0) - 1) == index
        ? context.padding.kZeroPadding
        : context.padding.bottomOnlyNormal;
    var mainSize = (state.taskItems?[index].isSwiped ?? false)
        ? trashButtonSize(context)
        : context.sized.kZero;
    var buttonStyle = ButtonStyle(
      padding: MaterialStatePropertyAll(context.padding.kZeroPadding),
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(trashButtonSize(context) / 2),
        ),
      ),
    );
    return AnimatedContainer(
      margin: mainMargin,
      duration: context.duration.durationFast,
      height: mainSize,
      width: mainSize,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(trashButtonSize(context) / 2),
      ),
      child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            // context.read<GlobalManageCubit>().deleteTaskItem(index);
            customAlertDialog(
                context: context,
                cubit: GlobalManageProvider.globalManageCubit,
                child: AreYouSureWantToDelete(index: index),
            );
          },
          child: const Icon(Icons.restore_from_trash_outlined)),
    );
  }
}

mixin _BodyPlaceLVBUtility {
  double trashButtonSize(BuildContext context) =>
      context.sized.dynamicHeigth(0.07);

  double addedCardHeight(BuildContext context) =>
      (context.sized.dynamicHeigth(0.115));
}
