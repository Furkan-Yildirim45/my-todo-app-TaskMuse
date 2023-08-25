import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';
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
      floatingActionButton: SizedBox(
        width: context.sized.dynamicWidth(0.6),
        height: context.sized.dynamicHeigth(0.07),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.aquaticCool.getColor()),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
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
                Text("Task",style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.aquaticCool.getColor())),
                Text("-Muse",style: context.general.textTheme.headlineMedium?.copyWith(color: AppColor.boatSwain.getColor())),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text("Management App",style: context.general.textTheme.titleMedium,),
            ),
            Container(
              height: context.sized.dynamicHeigth(0.45),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/get_started.png"),fit: BoxFit.cover)
              ),
            ),
            Text("Reminders Made Simple",style: context.general.textTheme.headlineSmall?.copyWith(color: AppColor.aquaticCool.getColor()),),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Organize all your To-do's lists and projects. Color tag then to set priorities and categories",
                style: context.general.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
