
part of'main_page.dart';

class _MainPageFloatActionButton extends StatefulWidget {
  const _MainPageFloatActionButton({Key? key}) : super(key: key);

  @override
  State<_MainPageFloatActionButton> createState() =>
      _MainPageFloatActionButtonState();
}

class _MainPageFloatActionButtonState extends State<_MainPageFloatActionButton>
    with MainBottomSheet {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.aquaticCool.getColor(),
      onPressed: _onPressedOfFloatActionButton,
      child: Icon(Icons.add, size: context.iconSize.large),
    );
  }

  void _onPressedOfFloatActionButton() {
    showCustomMainBottomSheet<GlobalManageCubit>(
      cubit: GlobalManageProvider.globalManageCubit,
      context: context,
      child: const MainPageBottomSheet(),
    );
  }
}
