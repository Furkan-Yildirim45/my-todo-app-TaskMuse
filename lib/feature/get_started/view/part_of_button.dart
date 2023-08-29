
part of"get_started_page_view.dart";

class _GetStartedPageFloatButton extends StatelessWidget with _PageSentenceUtility{
  _GetStartedPageFloatButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.dynamicWidth(0.6),
      height: context.sized.dynamicHeigth(0.07),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
            MaterialStatePropertyAll(AppColor.aquaticCool.getColor()),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: context.border.smallBorderRadius))),
        onPressed: () {
          context.route.navigatePush(const MainPage());
        },
        child: Text(buttonText),
      ),
    );
  }
}