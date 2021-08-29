import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'module.dart';
import '../constants/colors.dart';
import '../constants/config_flags.dart';
import '../modules/generated_bindings.dart' as raylib_bind;

class Core extends RaylibModule {
  // Constructs the core module.
  Core(raylib_bind.DartRaylib raylib) : super(raylib);

  // A pointer to dynamically allocated window title (c-string).
  ffi.Pointer<Utf8> _windowTitle = ffi.nullptr;

  // A pointer to dynamically allocated clipboard content (c-string).
  ffi.Pointer<Utf8> _clipboardContent = ffi.nullptr;

  // Constants for native boolean values.
  static const TRUE = raylib_bind.bool.true_1;
  static const FALSE = raylib_bind.bool.false_1;

  // Converts given strings to native utf-8 strings
  // and exposes it as a int8 pointer.
  ffi.Pointer<Utf8> _toInt8(String string) {
    return string.toNativeUtf8();
  }

  // **************** Window related APIs. ****************

  // Initialize window and OpenGL context
  void InitWindow(int width, int height, String title) {
    malloc.free(_windowTitle);
    _windowTitle = _toInt8(title);
    raylib.InitWindow(width, height, _windowTitle.cast<ffi.Int8>());
  }

  // Check if KEY_ESCAPE pressed or Close icon pressed
  bool get shouldWindowClose => (raylib.WindowShouldClose() == TRUE);

  // Close window and unload OpenGL context
  void CloseWindow() {
    malloc.free(_windowTitle);
    raylib.CloseWindow();
  }

  // Check if window has been initialized successfully
  bool get isWindowReady => (raylib.IsWindowReady() == TRUE);

  // Check if window is currently fullscreen
  bool get isWindowFullScreen => (raylib.IsWindowFullscreen() == TRUE);

  // Check if window is currently hidden (only PLATFORM_DESKTOP)
  bool get isWindowHidden => (raylib.IsWindowHidden() == TRUE);

  // Check if window is currently minimized (only PLATFORM_DESKTOP)
  bool get isWindowMinimized => (raylib.IsWindowMinimized() == TRUE);

  // Check if window is currently maximized (only PLATFORM_DESKTOP)
  bool get isWindowMaximized => (raylib.IsWindowMaximized() == TRUE);

  // Check if window is currently focused (only PLATFORM_DESKTOP)
  bool get isWindowFocused => (raylib.IsWindowFocused() == TRUE);

  // Check if window has been resized last frame
  bool get isWindowResized => (raylib.IsWindowResized() == TRUE);

  // Check if one specific window flag is enabled
  bool IsWindowState(WindowConfigFlag flag) {
    var isSet = false;
    if (_configFlags[flag] != null) {
      isSet = (raylib.IsWindowState(_configFlags[flag]!) == TRUE);
    } else {
      throw ArgumentError.value(
          flag, 'flag', 'Does not map to any native window config flag.');
    }
    return isSet;
  }

  // Set window configuration state using flags
  void SetWindowState(List<WindowConfigFlag> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_configFlags[flag] != null) {
        bitMaskedFlag |= _configFlags[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native window config flag.');
      }
    }
    raylib.SetWindowState(bitMaskedFlag);
  }

  // Clear window configuration state flags
  void ClearWindowState(List<WindowConfigFlag> flags) {
    var bitMaskedFlag = 0;

    for (final flag in flags) {
      if (_configFlags[flag] != null) {
        bitMaskedFlag |= _configFlags[flag]!;
      } else {
        throw ArgumentError.value(
            flag,
            'flags.elementAt(${flags.indexOf(flag)})',
            'Does not map to any native window config flag.');
      }
    }
    raylib.ClearWindowState(bitMaskedFlag);
  }

  // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
  void ToggleFullscreen() {
    raylib.ToggleFullscreen();
  }

  // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
  void MaximizeWindow() {
    raylib.MaximizeWindow();
  }

  // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
  void MinimizeWindow() {
    raylib.MinimizeWindow();
  }

  // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
  void RestoreWindow() {
    raylib.RestoreWindow();
  }

  // // Set icon for window (only PLATFORM_DESKTOP)
  // void SetWindowIcon(Image image);

  // Set title for window (only PLATFORM_DESKTOP)
  set windowTitle(String title) {
    malloc.free(_windowTitle);
    _windowTitle = _toInt8(title);
    raylib.SetWindowTitle(_windowTitle.cast<ffi.Int8>());
  }

  // Set window position on screen (only PLATFORM_DESKTOP)
  void SetWindowPosition(int x, int y) {
    raylib.SetWindowPosition(x, y);
  }

  // Set monitor for the current window (fullscreen mode)
  set windowMonitor(int monitor) => raylib.SetWindowMonitor(monitor);

  // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  void SetWindowMinSize(int width, int height) {
    raylib.SetWindowMinSize(width, height);
  }

  // Set window dimensions
  void SetWindowSize(int width, int height) {
    raylib.SetWindowMinSize(width, height);
  }

  // Get native window handle
  ffi.Pointer<ffi.Void> get windowHandle => raylib.GetWindowHandle();

  // Get current screen width
  int get screenWidth => raylib.GetScreenWidth();

  // Get current screen height
  int get screenHeight => raylib.GetScreenHeight();

  // Get number of connected monitors
  int get monitorCount => raylib.GetMonitorCount();

  // Get current connected monitor
  int get currentMonitor => raylib.GetCurrentMonitor();

  // Get specified monitor position
  raylib_bind.Vector2 GetMonitorPosition(int monitor) {
    return raylib.GetMonitorPosition(monitor);
  }

  // Get specified monitor width (max available by monitor)
  int GetMonitorWidth(int monitor) {
    return raylib.GetMonitorWidth(monitor);
  }

  // Get specified monitor height (max available by monitor)
  int GetMonitorHeight(int monitor) {
    return raylib.GetMonitorHeight(monitor);
  }

  // Get specified monitor physical width in millimetres
  int GetMonitorPhysicalWidth(int monitor) {
    return raylib.GetMonitorPhysicalWidth(monitor);
  }

  // Get specified monitor physical height in millimetres
  int GetMonitorPhysicalHeight(int monitor) {
    return raylib.GetMonitorPhysicalHeight(monitor);
  }

  // Get specified monitor refresh rate
  int GetMonitorRefreshRate(int monitor) {
    return raylib.GetMonitorRefreshRate(monitor);
  }

  // Get window position XY on monitor
  raylib_bind.Vector2 get windowPosition => raylib.GetWindowPosition();

  // Get window scale DPI factor
  raylib_bind.Vector2 get windowScaleDPI => raylib.GetWindowScaleDPI();

  // Get the human-readable, UTF-8 encoded name of the primary monitor
  String GetMonitorName(int monitor) {
    return raylib.GetMonitorName(monitor).cast<Utf8>().toDartString();
  }

  // Set clipboard text content
  set clipboardText(String text) {
    malloc.free(_clipboardContent);
    _clipboardContent = _toInt8(text);
    raylib.SetClipboardText(_clipboardContent.cast<ffi.Int8>());
  }

  // Get clipboard text content
  String get clipboardText =>
      raylib.GetClipboardText().cast<Utf8>().toDartString();

  /// Maps user facing [WindowConfigFlag] to native [ConfigFlags]
  static const Map<WindowConfigFlag, int> _configFlags = {
    WindowConfigFlag.FLAG_VSYNC_HINT: raylib_bind.ConfigFlags.FLAG_VSYNC_HINT,
    WindowConfigFlag.FLAG_FULLSCREEN_MODE:
        raylib_bind.ConfigFlags.FLAG_FULLSCREEN_MODE,
    WindowConfigFlag.FLAG_WINDOW_RESIZABLE:
        raylib_bind.ConfigFlags.FLAG_WINDOW_RESIZABLE,
    WindowConfigFlag.FLAG_WINDOW_UNDECORATED:
        raylib_bind.ConfigFlags.FLAG_WINDOW_UNDECORATED,
    WindowConfigFlag.FLAG_WINDOW_HIDDEN:
        raylib_bind.ConfigFlags.FLAG_WINDOW_HIDDEN,
    WindowConfigFlag.FLAG_WINDOW_MINIMIZED:
        raylib_bind.ConfigFlags.FLAG_WINDOW_MINIMIZED,
    WindowConfigFlag.FLAG_WINDOW_MAXIMIZED:
        raylib_bind.ConfigFlags.FLAG_WINDOW_MAXIMIZED,
    WindowConfigFlag.FLAG_WINDOW_UNFOCUSED:
        raylib_bind.ConfigFlags.FLAG_WINDOW_UNFOCUSED,
    WindowConfigFlag.FLAG_WINDOW_TOPMOST:
        raylib_bind.ConfigFlags.FLAG_WINDOW_TOPMOST,
    WindowConfigFlag.FLAG_WINDOW_ALWAYS_RUN:
        raylib_bind.ConfigFlags.FLAG_WINDOW_ALWAYS_RUN,
    WindowConfigFlag.FLAG_WINDOW_TRANSPARENT:
        raylib_bind.ConfigFlags.FLAG_WINDOW_TRANSPARENT,
    WindowConfigFlag.FLAG_WINDOW_HIGHDPI:
        raylib_bind.ConfigFlags.FLAG_WINDOW_HIGHDPI,
    WindowConfigFlag.FLAG_MSAA_4X_HINT:
        raylib_bind.ConfigFlags.FLAG_MSAA_4X_HINT,
    WindowConfigFlag.FLAG_INTERLACED_HINT:
        raylib_bind.ConfigFlags.FLAG_INTERLACED_HINT,
  };

  // **************** Cursor related APIs. ****************

  void ShowCursor() {
    raylib.ShowCursor();
  }

  // Hides cursor
  void HideCursor() {
    raylib.HideCursor();
  }

  // Check if cursor is not visible
  bool get isCursorHidden => (raylib.IsCursorHidden() == TRUE);

  // Enables cursor (unlock cursor)
  void EnableCursor() {
    raylib.EnableCursor();
  }

  // Disables cursor (lock cursor)
  void DisableCursor() {
    raylib.DisableCursor();
  }

  // Check if cursor is on the current screen.
  bool get isCursorOnScreen => (raylib.IsCursorOnScreen() == TRUE);

  // **************** Drawing related APIs. ****************

  // Set background color (framebuffer clear color)
  void ClearBackground(RaylibColor color) {
    raylib.ClearBackground(color.toInt32());
  }

  // Setup canvas (framebuffer) to start drawing
  void BeginDrawing() {
    raylib.BeginDrawing();
  }

  // End canvas drawing and swap buffers (double buffering)
  void EndDrawing() {
    raylib.EndDrawing();
  }

  // Initialize 2D mode with custom camera (2D)
  void BeginMode2D(raylib_bind.Camera2D camera) {
    raylib.BeginMode2D(camera);
  }

  // Ends 2D mode with custom camera
  void EndMode2D() {
    raylib.EndMode2D();
  }

  // Initializes 3D mode with custom camera (3D)
  void BeginMode3D(raylib_bind.Camera3D camera) {
    raylib.BeginMode3D(camera);
  }

  // Ends 3D mode and returns to default 2D orthographic mode
  void EndMode3D() {
    raylib.EndMode3D();
  }

  // Initializes render texture for drawing
  void BeginTextureMode(raylib_bind.RenderTexture target) {
    raylib.BeginTextureMode(target);
  }

  // Ends drawing to render texture
  void EndTextureMode() {
    raylib.EndTextureMode();
  }

  // Begin custom shader drawing
  void BeginShaderMode(raylib_bind.Shader shader) {
    raylib.BeginShaderMode(shader);
  }

  // End custom shader drawing (use default shader)
  void EndShaderMode() {
    raylib.EndShaderMode();
  }

  // Begin blending mode (alpha, additive, multiplied)
  void BeginBlendMode(int mode) {
    raylib.BeginBlendMode(mode);
  }

  // End blending mode (reset to default: alpha blending)
  void EndBlendMode() {
    raylib.EndBlendMode();
  }

  // Begin scissor mode (define screen area for following drawing)
  void BeginScissorMode(int x, int y, int width, int height) {
    raylib.BeginScissorMode(x, y, width, height);
  }

  // End scissor mode
  void EndScissorMode() {
    raylib.EndScissorMode();
  }

  // Begin stereo rendering (requires VR simulator)
  void BeginVrStereoMode(raylib_bind.VrStereoConfig config) {
    raylib.BeginVrStereoMode(config);
  }

  // End stereo rendering (requires VR simulator)
  void EndVrStereoMode() {
    raylib.EndVrStereoMode();
  }

  // **************** Timing related APIs. ****************

  // Set target FPS (maximum)
  set targetFPS(int fps) {
    raylib.SetTargetFPS(fps);
  }

  // Returns current FPS
  int get fps => raylib.GetFPS();

  // Returns time in seconds for last frame drawn (delta time)
  double get frameTime => raylib.GetFrameTime();

  // Returns elapsed time in seconds since InitWindow()
  double get time => raylib.GetTime();

  // **************** VR stereo config functions for VR simulator. ****************

  // Load VR stereo config for VR simulator device parameters
  raylib_bind.VrStereoConfig LoadVrStereoConfig(
      raylib_bind.VrDeviceInfo device) {
    return raylib.LoadVrStereoConfig(device);
  }

  // Unload VR stereo config
  void UnloadVrStereoConfig(raylib_bind.VrStereoConfig config) {
    raylib.UnloadVrStereoConfig(config);
  }
}
