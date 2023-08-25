part of"main_bottom_sheet.dart";

class _BaseSheetHeaderComponent extends StatelessWidget
    with _BaseSheetHeaderComponentUtility {
  _BaseSheetHeaderComponent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: generalSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -generalSize / 2,
            child: InkWell(
                borderRadius: BorderRadius.circular(generalSize / 2),
                child: Container(
                    width: generalSize,
                    height: generalSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(generalSize / 2),
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 35,
                    )),
                onTap: () {
                  Navigator.of(context).pop<bool>(true);
                }),
          ),
        ]
      ),
    );
  }
}
