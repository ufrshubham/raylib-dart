import 'dart:io';
import 'dart:ffi' as ffi;

import 'package:path/path.dart' as path;
import 'package:raylib_dart/src/modules/core.dart';
import 'modules/generated_bindings.dart' as raylib_bind;

// Represents a dart interface for interacting with Raylib.
class Raylib {
  // Internal reference to raylib c-library.
  late raylib_bind.DartRaylib raylib;

  // Holds reference to raylib core module.
  late final Core core;

  /// Creates a new [Raylib] object. Creating multiple object
  /// does not really much much difference because the underlying native
  /// raylib library will still be loaded only once.
  Raylib() {
    var raylibDllPath = Directory.current.path;
    if (Platform.isWindows) {
      raylibDllPath = path.join(
          Directory.current.path, 'lib/src/raylib/lib/windows/raylib.dll');
    } else {
      throw UnsupportedError('Current platform is not supported yet.');
    }
    raylib = raylib_bind.DartRaylib(ffi.DynamicLibrary.open(raylibDllPath));
    core = Core(raylib);
  }
}
