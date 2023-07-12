import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_muse/buttom_sheet/main_custom_bottom_sheet.dart';
import 'package:task_muse/const/colors.dart';
import 'package:task_muse/extension/device_size.dart';
import 'package:task_muse/extension/text_theme.dart';
import 'package:task_muse/general_datas.dart';
import 'package:task_muse/product/widget/text_with_space.dart';
import 'package:task_muse/product/widget/to_do_card.dart';

import 'core/custom_image_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainBottomSheet{
  final ProjectColors _projectColors = ProjectColors();
  late int bottomNavIndex;
  @override
  void initState() {
    super.initState();
    bottomNavIndex = _BottomNavItems.home.index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _projectColors.aquaticCool,
        onPressed: (){
          showCustomMainBottomSheet(context: context,
            child: Column(
              children: [
                Text("Create a task"),
              ],
            ),
          );
        },
        child: const Icon(Icons.add,size: 40),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //top component
            Container(
              height: context.getDeviceHeight(context) * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: _projectColors.aquaticCool,
                  image: const DecorationImage(
                      image: AssetImage("assets/images/buble.png"),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  //top of top place
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello Olivia!",
                            style: context
                                .getTextTheme(context)
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          const TitleSmallTextWithSpace(text: "Today you have 9 tasks",)
                        ],
                      ),
                      const ImageContainer(image: "assets/images/person_girl.png",)
                    ],
                  ),
                  //bottom of top place
                  Container(
                    width: double.infinity,
                    height: context.getDeviceHeight(context) * 0.15,
                    decoration: BoxDecoration(
                      color: _projectColors.dragonFly,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Stack(
                            children: [
                               Padding(
                                padding: const EdgeInsets.only(left: 18.0,right: 27),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Today Reminder",style: context.getTextTheme(context).titleLarge?.copyWith(color: Colors.white),),
                                        const TitleSmallTextWithSpace(text: "Meeting with client",top: 5,),
                                        const TitleSmallTextWithSpace(text: "10.00 AM",top: 5,),
                                      ],
                                    ),
                                    const ImageContainer(
                                      image: "assets/images/notification.png",
                                      height: 80,
                                      width: 80,
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: (){},
                                  child: Container(
                                      width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                      child: const Icon(Icons.close,size: 20,color: Colors.white,),
                                  ),
                                ),
                              ),
                            ]),
                      )
                ]),
              ),
            ),
            //body component
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: double.infinity,
                  color: _projectColors.enoki,
                  child: ListView(
                    children: [
                      _bodyText(context: context, text: "Today's Tasks"),
                      SizedBox(
                        height: context.getDeviceHeight(context) * 0.1 * (GeneralDatas.toDoCardItems?.length ?? 0) + 40 ,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: GeneralDatas.toDoCardItems?.length,
                          itemBuilder: (context, index) => ToDoCard(index: index),
                        ),
                      ),
                      _bodyText(context: context, text: "Tomorrow Tasks"),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  ConvexAppBar _bottomNavBar() {
    return ConvexAppBar(
      curveSize: 0,
      top: 0,
      initialActiveIndex: _BottomNavItems.home.index,
      backgroundColor: Colors.white,
      activeColor: _projectColors.aquaticCool,
      color: Colors.grey,
      items: [
        TabItem(icon: Icons.home_outlined,title: _BottomNavItems.home.setBottomNavItemsName()),
        TabItem(icon: Icons.assignment,title: _BottomNavItems.tasks.setBottomNavItemsName()),
      ],
    );
  }
  Padding _bodyText({required BuildContext context, required String text}) {
    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(text,style: context.getTextTheme(context).titleMedium?.copyWith(color: _projectColors.boatSwain),),
                      );
  }
}

enum _BottomNavItems{
  home,tasks
}

extension _BottomNavItemsExtension on _BottomNavItems{
  String setBottomNavItemsName(){
    switch(this){
      case _BottomNavItems.home:
        return "Home";
      case _BottomNavItems.tasks:
        return "Tasks";
    }
  }
}

///tıklanma kısımlarında active pasive kısımlarını yapmak!
/// senaryoya göre şekillendirilecek bi app!