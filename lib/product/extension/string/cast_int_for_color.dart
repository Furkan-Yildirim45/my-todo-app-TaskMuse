extension CastIntForColor on String{
  int get colorValue{
    var newColor = replaceFirst("#", "0xff");
    return int.parse(newColor);
  }
}