part of 'core.dart';

// Wrapper over raylib colors.
class _RaylibColor {
  late final raylib_bind.DartRaylib _raylib;

  _RaylibColor(raylib_bind.DartRaylib raylib) {
    _raylib = raylib;
  }

  // Creates an object of Color with given RGBA values.
  // Each channel showing be between 0-255.
  raylib_bind.Color fromRGBA(int r, int g, int b, int a) =>
      _raylib.CreateColor(r, g, b, a);

  // Light Gray
  raylib_bind.Color get lightGray => _raylib.CreateColor(200, 200, 200, 255);
  // Gray
  raylib_bind.Color get gray => _raylib.CreateColor(130, 130, 130, 255);
  // Dark Gray
  raylib_bind.Color get darkGray => _raylib.CreateColor(80, 80, 80, 255);
  // Yellow
  raylib_bind.Color get yellow => _raylib.CreateColor(253, 249, 0, 255);
  // Gold
  raylib_bind.Color get gold => _raylib.CreateColor(255, 203, 0, 255);
  // Orange
  raylib_bind.Color get orange => _raylib.CreateColor(255, 161, 0, 255);
  // Pink
  raylib_bind.Color get pink => _raylib.CreateColor(255, 109, 194, 255);
  // Red
  raylib_bind.Color get red => _raylib.CreateColor(230, 41, 55, 255);
  // Maroon
  raylib_bind.Color get maroon => _raylib.CreateColor(190, 33, 55, 255);
  // Green
  raylib_bind.Color get green => _raylib.CreateColor(0, 228, 48, 255);
  // Lime
  raylib_bind.Color get lime => _raylib.CreateColor(0, 158, 47, 255);
  // Dark Green
  raylib_bind.Color get darkGreen => _raylib.CreateColor(0, 117, 44, 255);
  // Sky Blue
  raylib_bind.Color get skyBlue => _raylib.CreateColor(102, 191, 255, 255);
  // Blue
  raylib_bind.Color get blue => _raylib.CreateColor(0, 121, 241, 255);
  // Dark Blue
  raylib_bind.Color get darkBlue => _raylib.CreateColor(0, 82, 172, 255);
  // Purple
  raylib_bind.Color get purple => _raylib.CreateColor(200, 122, 255, 255);
  // Violet
  raylib_bind.Color get violet => _raylib.CreateColor(135, 60, 190, 255);
  // Dark Purple
  raylib_bind.Color get darkPurple => _raylib.CreateColor(112, 31, 126, 255);
  // Beige
  raylib_bind.Color get beige => _raylib.CreateColor(211, 176, 131, 255);
  // Brown
  raylib_bind.Color get brown => _raylib.CreateColor(127, 106, 79, 255);
  // Dark Brown
  raylib_bind.Color get darkBrown => _raylib.CreateColor(76, 63, 47, 255);
  // White
  raylib_bind.Color get white => _raylib.CreateColor(255, 255, 255, 255);
  // Black
  raylib_bind.Color get black => _raylib.CreateColor(0, 0, 0, 255);
  // Blank (Transparent)
  raylib_bind.Color get blank => _raylib.CreateColor(0, 0, 0, 0);
  // Magenta
  raylib_bind.Color get magenta => _raylib.CreateColor(255, 0, 255, 255);
  // My own White (raylib logo)
  raylib_bind.Color get rayWhite => _raylib.CreateColor(245, 245, 245, 255);
}
