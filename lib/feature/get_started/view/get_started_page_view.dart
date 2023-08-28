import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/extension/context/size.dart';
import '../../../core/const/colors.dart';
import '../../main_page/view/main_page_view.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const _GetStartedPageFloatButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [
            _titleAppName(context),
            _textManagementApp(context),
            _appStartImageBody(context),
            _textAppReminder(context),
            _textAppInformation(context),
          ]),
        ),
      ),
    );
  }

  Padding _textAppInformation(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Organize all your To-do's lists and projects. Color tag then to set priorities and categories",
              style: context.general.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          );
  }

  Text _textAppReminder(BuildContext context) => Text(
        "Reminders Made Simple",
        style: context.general.textTheme.headlineSmall
            ?.copyWith(color: AppColor.aquaticCool.getColor()),
      );

  Container _appStartImageBody(BuildContext context) {
    return Container(
            height: context.sized.dynamicHeigth(0.45),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/get_started.png"),fit: BoxFit.cover)
            ),
          );
  }

  Padding _textManagementApp(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("Management App",style: context.general.textTheme.titleMedium,),
          );
  }

  Row _titleAppName(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Task",style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.aquaticCool.getColor())),
              Text("-Muse",style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.boatSwain.getColor())),
            ],
          );
  }
}

class _GetStartedPageFloatButton extends StatelessWidget {
  const _GetStartedPageFloatButton();

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
                borderRadius: BorderRadius.circular(12)))),
        onPressed: () {
          context.route.navigatePush(const MainPage());
        },
        child: const Text("Get Started"),
      ),
    );
  }
}
