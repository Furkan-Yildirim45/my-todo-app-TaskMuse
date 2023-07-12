import 'package:flutter/material.dart';
import 'package:task_muse/extension/device_size.dart';
import 'package:task_muse/extension/text_theme.dart';
import 'package:task_muse/main_page.dart';

import 'const/colors.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final ProjectColors _projectColors = ProjectColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.getDeviceWidth(context) * 0.6,
        height: context.getDeviceHeight(context) * 0.07,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(_projectColors.aquaticCool),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage(),));
          },
          child: const Text("Get Started"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Task",style: context.getTextTheme(context).headlineMedium?.copyWith(color: _projectColors.aquaticCool)),
                Text("-Muse",style: context.getTextTheme(context).headlineMedium?.copyWith(color: _projectColors.boatSwain)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text("Management App",style: context.getTextTheme(context).titleMedium,),
            ),
            Container(
              height: context.getDeviceHeight(context) * 0.45,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/get_started.png"),fit: BoxFit.cover)
              ),
            ),
            Text("Reminders Made Simple",style: context.getTextTheme(context).headlineSmall?.copyWith(color: _projectColors.aquaticCool),),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Organize all your To-do's lists and projects. Color tag then to set priorities and categories",
                style: context.getTextTheme(context).titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
