import 'dart:ffi';

import 'package:raylib_dart/raylib_dart.dart';
import 'package:raylib_dart/src/constants/colors.dart';

import 'package:ffi/ffi.dart';

void main() {
  final raylib = Raylib();
  final core = raylib.core;
  const WIDTH = 1280 ~/ 2;
  const HEIGHT = 720 ~/ 2;
  const FONT_SIZE_MIN = 20;
  const FONT_SIZE_MAX = 25;

  core.InitWindow(WIDTH, HEIGHT, 'Hello Raylib!');
  core.targetFPS = 60;

  const text = 'Welcome to Raylib-Dart!';
  // Some allocation and casting to convert dart string into native c-string.
  final utf8Text = text.toNativeUtf8();
  final int8Text = utf8Text.cast<Int8>();

  var fontSize = FONT_SIZE_MIN;
  var reverse = false;
  var time = 0.0;

  while (!core.shouldWindowClose) {
    if (fontSize > FONT_SIZE_MAX) {
      reverse = true;
    } else if (fontSize < FONT_SIZE_MIN) {
      reverse = false;
    }

    time += core.frameTime;
    if (time > 0.06) {
      fontSize += reverse ? -1 : 1;
      time -= 0.06;
    }

    core.BeginDrawing();
    core.ClearBackground(RaylibColor.BLACK);

    raylib.raylib.DrawFPS(32, 32);
    raylib.raylib.DrawText(
      int8Text,
      (WIDTH - raylib.raylib.MeasureText(int8Text, fontSize)) ~/ 2,
      HEIGHT ~/ 2,
      fontSize,
      RaylibColor.WHITE.toInt32(),
    );

    core.EndDrawing();
  }

  // Because we are no longer in managed-memory relm.
  malloc.free(utf8Text);
  core.CloseWindow();
}
