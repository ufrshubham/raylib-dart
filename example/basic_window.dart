import 'dart:ffi';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:raylib_dart/raylib_dart.dart';

import 'package:ffi/ffi.dart';

void main() {
  final raylibPath = path.join(
      Directory.current.path, 'vendors/raylib/build/raylib/Release/raylib.dll');

  final raylib = Raylib(raylibPath);
  final core = raylib.core;
  const screenWidth = 1280 ~/ 2;
  const screenHeight = 720 ~/ 2;
  const minFontSize = 20;
  const maxFontSize = 25;

  core.initWindow(screenWidth, screenHeight, 'Hello Raylib!');
  core.targetFPS = 60;

  const text = 'Welcome to Raylib-Dart!';
  // Some allocation and casting to convert dart string into native c-string.
  final utf8Text = text.toNativeUtf8();
  final int8Text = utf8Text.cast<Int8>();

  var fontSize = minFontSize;
  var reverse = false;
  var time = 0.0;

  while (!core.shouldWindowClose) {
    if (fontSize > maxFontSize) {
      reverse = true;
    } else if (fontSize < minFontSize) {
      reverse = false;
    }

    time += core.frameTime;
    if (time > 0.06) {
      fontSize += reverse ? -1 : 1;
      time -= 0.06;
    }

    core.beginDrawing();
    core.clearBackground(core.colors.black);

    raylib.raylib.DrawFPS(32, 32);
    raylib.raylib.DrawText(
      int8Text,
      (screenWidth - raylib.raylib.MeasureText(int8Text, fontSize)) ~/ 2,
      screenHeight ~/ 2,
      fontSize,
      core.colors.brown,
    );

    core.endDrawing();
  }

  // Because we are no longer in managed-memory relm.
  malloc.free(utf8Text);
  core.closeWindow();
}
