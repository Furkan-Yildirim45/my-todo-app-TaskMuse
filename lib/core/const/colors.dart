
import 'dart:ui';

enum AppColor{
  boatSwain,
  aquaticCool,
  dragonFly,
  enoki,
  mikadoYellow,
  monastic,
  walledGarden,
  candyDrop,
  dandelionWish,
  atomicOrange,
  defaultColor,
  teal,
  purple,
  pink,
  red,
  lavender,
  brown,
  seaBlue
}

extension AppColorExtension on AppColor{
  Color getColor(){
    switch(this){
      case AppColor.boatSwain:
        return const Color(0xff223356);
      case AppColor.aquaticCool:
        return const Color(0xff239dbb); //1
      case AppColor.dragonFly:
        return const Color(0xff65bccd); //6
      case AppColor.enoki:
        return const Color(0xfff6faee);
      case AppColor.mikadoYellow:
        return const Color(0xfffec00d); //3
      case AppColor.monastic:
        return const Color(0xffaaaad7); //4
      case AppColor.walledGarden:
        return const Color(0xff15d436); //5
      case AppColor.candyDrop:
        return const Color(0xffc0626c); //2
      case AppColor.dandelionWish:
        return const Color(0xffe4b767); //+6
      case AppColor.atomicOrange:
        return const Color(0xfffc8404); //+2
      case AppColor.defaultColor:
        return const Color(0xff808080); //+1
      case AppColor.teal:
        return const Color(0xff009688); //10
      case AppColor.purple:
        return const Color(0xff9C27B0); //9
      case AppColor.pink:
        return const Color(0xffe91e63); //8
      case AppColor.red:
        return const Color(0xfff44336); //7
      case AppColor.lavender:
        return const Color(0xff556B2F); //+3
      case AppColor.brown:
        return const Color(0xffA52A2A); //+4
      case AppColor.seaBlue:
        return const Color(0xff1e90ff); //+5

    }
  }
}