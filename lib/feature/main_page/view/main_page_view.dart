import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_muse/product/extension/context/general.dart';
import 'package:task_muse/product/extension/context/size.dart';
import 'package:task_muse/product/widget/text_with_space.dart';
import 'package:task_muse/product/widget/to_do_card.dart';
import '../../../core/const/colors.dart';
import '../../../core/widget/custom_image_container.dart';
import '../../../product/utility/hive_manager.dart';
import '../../bottom_sheet/main_bottom_sheet.dart';
import '../model/task_model.dart';
import 'main_page_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainBottomSheet{
  late int bottomNavIndex;
  List<TaskModel>? taskItems;
  late final TaskCacheManager _instance;

  @override
  void initState() {
    super.initState();
    TaskCacheManager.initialize(key: CachingKeys.taskList);
    _instance = TaskCacheManager.instance;
    bottomNavIndex = _BottomNavItems.home.index;
    _initAlize();
  }

  Future<void> _initAlize() async {
    await _instance.init();
    if(_instance.getValues?.isNotEmpty ?? false){
      taskItems = _instance.getValues;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.aquaticCool.getColor(),
        onPressed: (){
          final result = showCustomMainBottomSheet(context: context,
            child: const MainPageBottomSheet(),
          );
          if(result is bool){
            setState(() {
              taskItems = _instance.getValues;
            });
          }
        },
        child: const Icon(Icons.add,size: 40),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //top component
            Container(
              height: context.sized.dynamicHeigth(0.3),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.aquaticCool.getColor(),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/buble.png"),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(18),
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
                                .general.textTheme
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
                    height: context.sized.dynamicHeigth( 0.15),
                    decoration: BoxDecoration(
                      color: AppColor.dragonFly.getColor(),
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
                                        Text("Today Reminder",style: context.general.textTheme.titleLarge?.copyWith(color: Colors.white),),
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
                  color: AppColor.enoki.getColor(),
                  child: ListView(
                    children: [
                      _bodyText(context: context, text: "Your Tasks"),
                      SizedBox(
                        height: context.sized.dynamicHeigth(0.1) * (taskItems?.length ?? 0) + 40 ,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: taskItems?.length ?? 0,
                          itemBuilder: (context, index) => ToDoCard(index: index),
                        ),
                      ),
                      (taskItems?.isEmpty ?? false) ? const Center(
                          child: CircularProgressIndicator()) : const SizedBox.shrink(),
                      Text('${taskItems?.length}')
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
      activeColor: AppColor.aquaticCool.getColor(),
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
                        child: Text(text,style: context.general.textTheme.titleMedium?.copyWith(color: AppColor.boatSwain.getColor()),),
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
