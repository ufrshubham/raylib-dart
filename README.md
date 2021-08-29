# Raylib-Dart

Dart bindings for raylib 3.7.0, a simple and easy-to-use library to learn videogames programming [www.raylib.com](www.raylib.com)

## Note

- This project is still work in progress and a lot of APIs from raylib are not yet exposed correctly
- Right now it only supports Windows

## Usage

A simple usage example:

```dart
import 'package:raylib_dart/raylib_dart.dart';

int main() {
  final raylib = Raylib();
  final core = raylib.core;

  core.InitWindow(1280, 720, 'Hello Raylib!');
  core.targetFPS = 60;

  while (!core.shouldWindowClose) {
    core.BeginDrawing();
    core.ClearBackground(RaylibColor.RAYWHITE);
    core.EndDrawing();
  }

  core.CloseWindow();
}
```
