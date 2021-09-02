import 'dart:ffi' as ffi;

import 'package:raylib_dart/src/modules/core.dart';
import 'modules/generated_bindings.dart' as raylib_bind;

// Represents a dart interface for interacting with Raylib.
class Raylib {
  // Internal reference to raylib c-library.
  late raylib_bind.DartRaylib raylib;

  // Holds reference to raylib core module.
  late final Core core;

  /// Creates a new [Raylib] object using the given full path to raylib library.
  /// Creating multiple object does not really make much difference because the
  /// underlying native raylib library will still be loaded only once.
  Raylib(String raylibPath) {
    raylib = raylib_bind.DartRaylib(ffi.DynamicLibrary.open(raylibPath));
    core = Core(raylib);
  }
}
