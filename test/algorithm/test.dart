import 'package:flutter_test/flutter_test.dart';
import 'package:task_muse/feature/home/model/personal_alarm_model.dart';

void main(){
  setUp(() {

  });
  test("find element of index", (){
    var tempList = PersonalAlarmModel.generateItems(count: 24);
    tempList[5].isSelected = true;
    var index = -1;
    for(var element in tempList){
      if(element.isSelected){
        index = tempList.indexOf(element);
      }
    }
    expect(index,5);
  });
}