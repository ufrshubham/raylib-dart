// Wrapper over raylib colors.
class RaylibColor {
  final int r;
  final int g;
  final int b;
  final int a;

  // Constructs a color from given rgba values.
  const RaylibColor(this.r, this.g, this.b, this.a);

  // Converts current color into a 32bit int.
  int toInt32() {
    return (r) | (g << 8) | (b << 16) | (a << 24);
  }

  // Light Gray
  static const lightGray = RaylibColor(200, 200, 200, 255);
  // Gray
  static const gray = RaylibColor(130, 130, 130, 255);
  // Dark Gray
  static const darkGray = RaylibColor(80, 80, 80, 255);
  // Yellow
  static const yellow = RaylibColor(253, 249, 0, 255);
  // Gold
  static const gold = RaylibColor(255, 203, 0, 255);
  // Orange
  static const orange = RaylibColor(255, 161, 0, 255);
  // Pink
  static const pink = RaylibColor(255, 109, 194, 255);
  // Red
  static const red = RaylibColor(230, 41, 55, 255);
  // Maroon
  static const maroon = RaylibColor(190, 33, 55, 255);
  // Green
  static const green = RaylibColor(0, 228, 48, 255);
  // Lime
  static const lime = RaylibColor(0, 158, 47, 255);
  // Dark Green
  static const darkGreen = RaylibColor(0, 117, 44, 255);
  // Sky Blue
  static const skyBlue = RaylibColor(102, 191, 255, 255);
  // Blue
  static const blue = RaylibColor(0, 121, 241, 255);
  // Dark Blue
  static const darkBlue = RaylibColor(0, 82, 172, 255);
  // Purple
  static const purple = RaylibColor(200, 122, 255, 255);
  // Violet
  static const violet = RaylibColor(135, 60, 190, 255);
  // Dark Purple
  static const darkPurple = RaylibColor(112, 31, 126, 255);
  // Beige
  static const beige = RaylibColor(211, 176, 131, 255);
  // Brown
  static const brown = RaylibColor(127, 106, 79, 255);
  // Dark Brown
  static const darkBrown = RaylibColor(76, 63, 47, 255);
  // White
  static const white = RaylibColor(255, 255, 255, 255);
  // Black
  static const black = RaylibColor(0, 0, 0, 255);
  // Blank (Transparent)
  static const blank = RaylibColor(0, 0, 0, 0);
  // Magenta
  static const magenta = RaylibColor(255, 0, 255, 255);
  // My own White (raylib logo)
  static const rayWhite = RaylibColor(245, 245, 245, 255);
}
