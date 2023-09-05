part of '../main_page_view.dart';

class _PageBodyComponent extends StatefulWidget {
  const _PageBodyComponent({Key? key}) : super(key: key);

  @override
  State<_PageBodyComponent> createState() => _PageBodyComponentState();
}

class _PageBodyComponentState extends State<_PageBodyComponent>
    with _PageOfBodyUtility {
  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().setItemsToTaskItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: context.padding.mediumSymmetricHorizontal,
            child: Container(
              width: context.sized.width,
              color: AppColor.enoki.getColor(),
              child: ListView(
                children: [
                  _bodyText(context: context, text: titleYourTask),
                  SizedBox(
                    height: addedCardHeight * (state.taskItems?.length ?? context.sized.kZero.toInt()),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.taskItems?.length ??
                          context.sized.kZero.toInt(),
                      itemBuilder: (context, index) => ToDoCard(index: index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

mixin _PageOfBodyUtility on State<_PageBodyComponent>{
  double get spaceWithFloatButton => context.sized.dynamicHeigth(0.06);
  double get addedCardHeight => (context.sized.dynamicHeigth(0.115));
  final String titleYourTask = "Your Tasks";
}

