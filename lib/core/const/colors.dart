
import 'dart:ui';

enum AppColor{
  boatSwain,aquaticCool,dragonFly,enoki,mikadoYellow,monastic,walledGarden,candyDrop,dandelionWish,atomicOrange,defaultColor,
}

extension AppColorExtension on AppColor{
  Color getColor(){
    switch(this){
      case AppColor.boatSwain:
        return const Color(0xff223356);
      case AppColor.aquaticCool:
        return const Color(0xff239dbb);
      case AppColor.dragonFly:
        return const Color(0xff65bccd);
      case AppColor.enoki:
        return const Color(0xfff6faee);
      case AppColor.mikadoYellow:
        return const Color(0xfffec00d);
      case AppColor.monastic:
        return const Color(0xffaaaad7);
      case AppColor.walledGarden:
        return const Color(0xff15d436);
      case AppColor.candyDrop:
        return const Color(0xffc0626c);
      case AppColor.dandelionWish:
        return const Color(0xffe4b767);
      case AppColor.atomicOrange:
        return const Color(0xfffc8404);
      case AppColor.defaultColor:
        return const Color(0xff808080);
    }
  }
}