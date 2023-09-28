part of '../../tasks_page_view.dart';

class _AppBarTextField extends StatefulWidget {
  const _AppBarTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final void Function(String value) onChanged;

  @override
  State<_AppBarTextField> createState() => _AppBarTextFieldState();
}

class _AppBarTextFieldState extends State<_AppBarTextField>
    with _AppBarTextFieldUtility {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AppBarSearchPlaceButton(
          onPressed: () {
            context.read<TasksCubit>().makeFalseIsSearchActive();
          },
          icon: Icons.arrow_back,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: context.sized.smallValue),
          width: context.sized.width - ((searchPlaceButtonSize(context) * 2) + context.sized.dynamicWidth(0.02)),
          child: BlocSelector<TasksCubit, TasksState, bool>(
            selector: (state) {
              return state.isSearchActive ?? false;
            },
            builder: (context, state) {
              return TextField(
                autofocus: state ? true : false,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintStyle: context.general.textTheme.titleLarge?.copyWith(
                        color: Colors.white, decoration: TextDecoration.none),
                    hintText: textFieldHintText,
                    border: InputBorder.none),
                style: context.general.textTheme.titleLarge?.copyWith(
                    color: Colors.white, decoration: TextDecoration.underline),
                maxLines: 1,
                onChanged: widget.onChanged,
                controller: _textEditingController,
              );
            },
          ),
        ),
        _AppBarSearchPlaceButton(
          icon: Icons.close,
          onPressed: () {
            _textEditingController.clear();
            context.read<TasksCubit>().makeTrueIsClickClear();
            widget.onChanged.call("");
          },
        ),
      ],
    );
  }
}

mixin _AppBarTextFieldUtility {
  double searchPlaceButtonSize(BuildContext context) =>
      context.sized.dynamicWidth(0.15);
  final TextEditingController _textEditingController = TextEditingController();

  double searchButtonSize(BuildContext context) =>
      context.sized.dynamicHeigth(0.07);

  final String textFieldHintText = "Search a task";
}
