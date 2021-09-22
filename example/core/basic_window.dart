import 'dart:ffi';
import 'package:raylib_dart/raylib_dart.dart';

import 'package:ffi/ffi.dart';

import '../common.dart';

void main() {
  String raylibPath = getRaylibPath();
  final raylib = Raylib(raylibPath);
  final core = raylib.core;

  // Initialization
  //--------------------------------------------------------------------------------------
  const int screenWidth = 800;
  const int screenHeight = 450;

  core.initWindow(
      screenWidth, screenHeight, 'raylib-dart [core] example - basic window');

  core.targetFPS = 60; // Set our game to run at 60 frames-per-second
  //--------------------------------------------------------------------------------------

  final text = 'Congrats! You created your first window!';

  Pointer<Utf8> utf8Text = nullptr;
  try {
    // Some allocation and casting to convert dart string into native c-string.
    utf8Text = text.toNativeUtf8();
    final int8Text = utf8Text.cast<Int8>();

    // Main game loop
    // Detect window close button or ESC key
    while (!core.shouldWindowClose) {
      // Update
      //----------------------------------------------------------------------------------
      // Update your variables here
      //----------------------------------------------------------------------------------

      // Draw
      //----------------------------------------------------------------------------------
      core.beginDrawing();
      core.clearBackground(core.colors.rayWhite);

      raylib.raylib.DrawText(
        int8Text,
        190,
        200,
        20,
        core.colors.lightGray,
      );

      core.endDrawing();
      //----------------------------------------------------------------------------------
    }
  } finally {
    // De-Initialization
    //--------------------------------------------------------------------------------------
    malloc.free(utf8Text); // Because we are no longer in managed-memory relm.
    core.closeWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
  }
}
