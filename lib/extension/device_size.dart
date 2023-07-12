
import 'package:flutter/cupertino.dart';

extension DeviceSizeExtension on BuildContext{
  double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}