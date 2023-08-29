

part of"../main_page_view.dart";

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
