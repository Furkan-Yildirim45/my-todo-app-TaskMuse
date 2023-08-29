part of '../main_page_view.dart';

class _PageBodyComponent extends StatefulWidget {
  const _PageBodyComponent({Key? key}) : super(key: key);

  @override
  State<_PageBodyComponent> createState() => _PageBodyComponentState();
}

class _PageBodyComponentState extends State<_PageBodyComponent> with _PageOfBodyUtility{
  List<TaskModel>? taskItems;
  late final TaskCacheManager _instance;

  @override
  void initState() {
    super.initState();
    TaskCacheManager.initialize(key: CachingKeys.taskList);
    _instance = TaskCacheManager.instance;
    _initAlize();
  }

  Future<void> _initAlize() async {
    await _instance.init();
    if (_instance.getValues?.isNotEmpty ?? false) {
      taskItems = _instance.getValues;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.padding.largeSymmetricHorizontal,
        child: Container(
            width: context.sized.width,
            color: AppColor.enoki.getColor(),
            child: ListView(
              children: [
                _bodyText(context: context, text: titleYourTask),
                SizedBox(
                  height: context.sized.largeValue *
                          (taskItems?.length ?? context.sized.kZero.toInt()) +
                      spaceWithFloatButton(context),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: taskItems?.length ?? context.sized.kZero.toInt(),
                    itemBuilder: (context, index) => ToDoCard(index: index),
                  ),
                ),
                (taskItems?.isEmpty ?? false)
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink(),
                Text('${taskItems?.length}')
              ],
            )),
      ),
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

mixin _PageOfBodyUtility{
  double spaceWithFloatButton(BuildContext context) => context.sized.dynamicHeigth(0.06);
  final String titleYourTask = "Your Tasks";
}
