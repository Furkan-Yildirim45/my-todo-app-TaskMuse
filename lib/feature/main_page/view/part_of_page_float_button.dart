
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
      shape: RoundedRectangleBorder(borderRadius: context.border.largeBorderRadius),
      backgroundColor: AppColor.aquaticCool.getColor(),
      onPressed: _onPressedOfFloatActionButton,
      child: Icon(Icons.add, size: context.iconSize.large,color: Colors.white,),
    );
  }

  void _onPressedOfFloatActionButton() {
    showCustomMainBottomSheet<GlobalManageCubit>(
      cubit: GlobalManageProvider.globalManageCubit,
      context: context,
      child: const HomePageBottomSheet( isEdit: false),
    );
  }
}
