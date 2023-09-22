part of '../home_view.dart';

class _PageBodyComponent extends StatelessWidget with _PageOfBodyUtility {
  _PageBodyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.padding.mediumSymmetricHorizontal,
        child: Container(
          width: context.sized.width,
          color: AppColor.enoki.getColor(),
          child: ListView(
            children: [
              _bodyText(context: context, text: titleYourTask),
              const _BodyPlaceListViewBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

mixin _PageOfBodyUtility {
  final String titleYourTask = "Your Tasks";

  Padding _bodyText({required BuildContext context, required String text}) {
    return Padding(
      padding: context.padding.normalSymmetricVertical,
      child: Text(
        text,
        style: context.general.textTheme.titleMedium
            ?.copyWith(color: AppColor.boatSwain.getColor()),
      ),
    );
  }
}
