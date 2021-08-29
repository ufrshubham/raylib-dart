// Wrapper over raylib colors.
class RaylibColor {
  final int red;
  final int green;
  final int blue;
  final int alpha;

  // Constructs a color from given rgba values.
  const RaylibColor(this.red, this.green, this.blue, this.alpha);

  // Converts current color into a 32bit int.
  int toInt32() {
    return (red) | (green << 8) | (blue << 16) | (alpha << 24);
  }

  // Light Gray
  static const LIGHTGRAY = RaylibColor(200, 200, 200, 255);
  // Gray
  static const GRAY = RaylibColor(130, 130, 130, 255);
  // Dark Gray
  static const DARKGRAY = RaylibColor(80, 80, 80, 255);
  // Yellow
  static const YELLOW = RaylibColor(253, 249, 0, 255);
  // Gold
  static const GOLD = RaylibColor(255, 203, 0, 255);
  // Orange
  static const ORANGE = RaylibColor(255, 161, 0, 255);
  // Pink
  static const PINK = RaylibColor(255, 109, 194, 255);
  // Red
  static const RED = RaylibColor(230, 41, 55, 255);
  // Maroon
  static const MAROON = RaylibColor(190, 33, 55, 255);
  // Green
  static const GREEN = RaylibColor(0, 228, 48, 255);
  // Lime
  static const LIME = RaylibColor(0, 158, 47, 255);
  // Dark Green
  static const DARKGREEN = RaylibColor(0, 117, 44, 255);
  // Sky Blue
  static const SKYBLUE = RaylibColor(102, 191, 255, 255);
  // Blue
  static const BLUE = RaylibColor(0, 121, 241, 255);
  // Dark Blue
  static const DARKBLUE = RaylibColor(0, 82, 172, 255);
  // Purple
  static const PURPLE = RaylibColor(200, 122, 255, 255);
  // Violet
  static const VIOLET = RaylibColor(135, 60, 190, 255);
  // Dark Purple
  static const DARKPURPLE = RaylibColor(112, 31, 126, 255);
  // Beige
  static const BEIGE = RaylibColor(211, 176, 131, 255);
  // Brown
  static const BROWN = RaylibColor(127, 106, 79, 255);
  // Dark Brown
  static const DARKBROWN = RaylibColor(76, 63, 47, 255);
  // White
  static const WHITE = RaylibColor(255, 255, 255, 255);
  // Black
  static const BLACK = RaylibColor(0, 0, 0, 255);
  // Blank (Transparent)
  static const BLANK = RaylibColor(0, 0, 0, 0);
  // Magenta
  static const MAGENTA = RaylibColor(255, 0, 255, 255);
  // My own White (raylib logo)
  static const RAYWHITE = RaylibColor(245, 245, 245, 255);
}
