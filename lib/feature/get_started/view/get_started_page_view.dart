import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_muse/product/extension/context/border_radius.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/navigation.dart';
import 'package:task_muse/product/extension/context/padding.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';
import '../../../core/const/colors.dart';
import '../../main_page/view/main_page_view.dart';

part 'part_of_button.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> with _PageSentenceUtility{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _GetStartedPageFloatButton(),
      body: SafeArea(
        child: Padding(
          padding: context.padding.dynamicAll(0.1),
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
            padding: context.padding.topOnlyNormal,
            child: Text(
              appInformationBody,
              style: context.general.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          );
  }

  Text _textAppReminder(BuildContext context) => Text(
    appInformationTitle,
        style: context.general.textTheme.headlineSmall
            ?.copyWith(color: AppColor.aquaticCool.getColor()),
      );

  Container _appStartImageBody(BuildContext context) {
    return Container(
            height: context.sized.dynamicHeigth(0.45),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(pageImageUrl),fit: BoxFit.cover)
            ),
          );
  }

  Padding _textManagementApp(BuildContext context) {
    return Padding(
            padding: context.padding.topOnlyNormal,
            child: Text(appForWhatText,style: context.general.textTheme.titleMedium,),
          );
  }

  Row _titleAppName(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appTitlePartOne,style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.aquaticCool.getColor())),
              Text(appTitlePartTwo,style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.boatSwain.getColor())),
            ],
          );
  }
}

mixin _PageSentenceUtility{
  final String buttonText = "Get Started";
  final String appTitlePartOne = "Task";
  final String appTitlePartTwo = "-Muse";
  final String appForWhatText = "Management App";
  final String pageImageUrl = "assets/images/get_started.png";
  final String appInformationTitle = "Reminders Made Simple";
  final String appInformationBody = "Organize all your To-do's lists and projects. Color tag then to set priorities and categories";
}