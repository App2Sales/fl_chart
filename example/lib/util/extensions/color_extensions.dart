import 'dart:ui';

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      _floatToInt8(alpha.toDouble()),
      (_floatToInt8(red.toDouble()) * value).round(),
      (_floatToInt8(green.toDouble()) * value).round(),
      (_floatToInt8(blue.toDouble()) * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      _floatToInt8(alpha.toDouble()),
      (_floatToInt8(red.toDouble()) + ((255 - _floatToInt8(red.toDouble())) * value)).round(),
      (_floatToInt8(green.toDouble()) + ((255 - _floatToInt8(green.toDouble())) * value)).round(),
      (_floatToInt8(blue.toDouble()) + ((255 - _floatToInt8(blue.toDouble())) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (_floatToInt8(this.red.toDouble()) + _floatToInt8(other.red.toDouble())) ~/ 2;
    final green = (_floatToInt8(this.green.toDouble()) + _floatToInt8(other.green.toDouble())) ~/ 2;
    final blue = (_floatToInt8(this.blue.toDouble()) + _floatToInt8(other.blue.toDouble())) ~/ 2;
    final alpha = (_floatToInt8(this.alpha.toDouble()) + _floatToInt8(other.alpha.toDouble())) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }

  // Int color components were deprecated in Flutter 3.27.0.
  // This method is used to convert the new double color components to the
  // old int color components.
  //
  // Taken from the Color class.
  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
