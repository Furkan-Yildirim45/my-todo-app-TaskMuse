

class PersonalAlarmModel{
  bool isSelected;
  PersonalAlarmModel({this.isSelected = false});

  static List<PersonalAlarmModel> generateItems({required int count}) {
    List<PersonalAlarmModel> people = [];
    for (int i = 0; i < count; i++) {
      people.add(PersonalAlarmModel());
    }
    return people;
  }
}