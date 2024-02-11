class PersonalAlarmModel {
  bool isSelected;

  PersonalAlarmModel({this.isSelected = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonalAlarmModel &&
              runtimeType == other.runtimeType &&
              isSelected == other.isSelected;

  @override
  int get hashCode => isSelected.hashCode;

  static List<PersonalAlarmModel> generateItems({required int count}) {
    List<PersonalAlarmModel> items = [];
    for (int i = 0; i < count; i++) {
      items.add(PersonalAlarmModel());
    }
    return items;
  }
}
