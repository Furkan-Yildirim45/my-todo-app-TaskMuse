part of'main_bottom_sheet.dart';

class _BaseSheetHeaderComponent extends StatelessWidget
    with _BaseSheetHeaderComponentUtility {
  _BaseSheetHeaderComponent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.middleButtonSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(context.sized.floatActionButtonSize / 2),
            child: InkWell(
                borderRadius: BorderRadius.circular(context.sized.floatActionButtonSize / 2),
                child: Container(
                    width: context.sized.floatActionButtonSize,
                    height: context.sized.floatActionButtonSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.sized.floatActionButtonSize / 2),
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: context.iconSize.large,
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<GlobalManageCubit>().makeIsActiveOfTagFalse();
                }),
          ),
        ]
      ),
    );
  }
}
