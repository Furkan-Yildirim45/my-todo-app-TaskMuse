part of '../../tasks_page_view.dart';

class _AppBarSearchPlaceButton extends StatelessWidget {
  const _AppBarSearchPlaceButton({Key? key, required this.icon, required this.onPressed}) : super(key: key);

  double searchPlaceButtonSize(BuildContext context) =>
      context.sized.dynamicWidth(0.12);
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: context.border.smallBorderRadius),
      width: searchPlaceButtonSize(context),
      height: searchPlaceButtonSize(context),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
