import '../modules/generated_bindings.dart' as raylib_bind;

abstract class RaylibModule {
  // Internal reference to raylib c-library.
  late final raylib_bind.DartRaylib raylib;

  RaylibModule(this.raylib);
}
