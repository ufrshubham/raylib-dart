import 'dart:io';
import 'package:path/path.dart' as path;

String getRaylibPath() {
  var raylibPath =
      path.join(Directory.current.path, 'vendors/raylib/build/raylib');

  // To be more specific, this path is platform + compiler dependent.
  // But in most cases, clients will just have to change extension (.dll, .so).
  if (Platform.isWindows) {
    raylibPath = path.join(raylibPath, 'Release/raylib.dll');
  } else if (Platform.isLinux) {
    raylibPath = path.join(raylibPath, 'libraylib.so');
  }
  return raylibPath;
}
