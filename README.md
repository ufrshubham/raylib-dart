# Raylib-Dart

Dart bindings for raylib 4.0.0, a simple and easy-to-use library to learn videogames programming [www.raylib.com](www.raylib.com)

## Note

- This project is still work in progress and a lot of APIs from raylib are not yet exposed correctly

- Right now it only supports Windows and Linux (in theory Mac should also work perfectly fine).

- This package uses a custom fork of [raylib](https://github.com/ufrshubham/raylib) added as submodule under vendors. So stock raylib binaries might not work.

- Some APIs from raylib are not exposed because I feel that dart already has native libraries to handle such things. For example:

  - Logging
  - File management (expect dropped file APIs)
  - MemAlloc and MemFree

## Usage

A simple usage example:

```dart
import 'package:raylib_dart/raylib_dart.dart';

int main() {
  // Might be a different path depending on your platform.
  final raylibPath = path.join(
    Directory.current.path, 'vendors/raylib/build/raylib/Release/raylib.dll');

  final raylib = Raylib(raylibPath);
  final core = raylib.core;

  core.initWindow(1280, 720, 'Hello Raylib!');
  core.targetFPS = 60;

  while (!core.shouldWindowClose) {
    core.beginDrawing();
    core.clearBackground(core.colors.black);
    core.endDrawing();
  }

  core.closeWindow();
}
```

## Todo

- [ ] Add idiomatic wrappers for all the auto-generated dart bindings.

- [ ] (In progress) Add APIs to create native raylib structs (like Vector2, Color, Vector3) from dart. See [structs example](https://github.com/dart-lang/samples/tree/master/ffi/structs) from dart ffi.

- [ ] Figure out best way to distribute platform specific raylib binaries with this package. See [sqflite](https://github.com/tekartik/sqflite/tree/master/sqflite_common_ffi) for reference.

- [ ] Get all the examples from raylib working with this package.

- [ ] Add build instructions for the forked version of raylib.

- [ ] Add instructions for development and contribution to this project.

## For discussions

- Use the [Discussions](https://github.com/ufrshubham/raylib-dart/discussions) tab

- Or join my [Discord](https://discord.gg/6xZ4ycWSYB)
