import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'module.dart';

import '../constants/config_flags.dart';
import '../modules/generated_bindings.dart' as raylib_bind;

class Core extends RaylibModule {
  // Constructs the core module.
  Core(raylib_bind.DartRaylib raylib) : super(raylib) {
    colors = _RaylibColor(raylib);
  }

  // Use this to access the OOTB colors from raylib.
  /// To create custom colors using [createColor].
  late final _RaylibColor colors;

  // A pointer to dynamically allocated window title (c-string).
  ffi.Pointer<Utf8> _windowTitle = ffi.nullptr;

  // A pointer to dynamically allocated clipboard content (c-string).
  ffi.Pointer<Utf8> _clipboardContent = ffi.nullptr;

  // Constants for native boolean values.
  static const _true = raylib_bind.bool.true_1;

  // Might need this in future.
  // ignore: unused_field
  static const _false = raylib_bind.bool.false_1;

  // Converts given strings to native utf-8 strings
  // and exposes it as a int8 pointer.
  ffi.Pointer<Utf8> _toInt8(String string) {
    return string.toNativeUtf8();
  }

  // **************** Window related APIs. ****************

  // Initialize window and OpenGL context
  void initWindow(int width, int height, String title) {
    malloc.free(_windowTitle);
    _windowTitle = _toInt8(title);
    raylib.InitWindow(width, height, _windowTitle.cast<ffi.Int8>());
  }

  // Check if KEY_ESCAPE pressed or Close icon pressed
  bool get shouldWindowClose => (raylib.WindowShouldClose() == _true);

  // Close window and unload OpenGL context
  void closeWindow() {
    malloc.free(_windowTitle);
    raylib.CloseWindow();
  }

  // Check if window has been initialized successfully
  bool get isWindowReady => (raylib.IsWindowReady() == _true);

  // Check if window is currently fullscreen
  bool get isWindowFullScreen => (raylib.IsWindowFullscreen() == _true);

  // Check if window is currently hidden (only PLATFORM_DESKTOP)
  bool get isWindowHidden => (raylib.IsWindowHidden() == _true);

  // Check if window is currently minimized (only PLATFORM_DESKTOP)
  bool get isWindowMinimized => (raylib.IsWindowMinimized() == _true);

  // Check if window is currently maximized (only PLATFORM_DESKTOP)
  bool get isWindowMaximized => (raylib.IsWindowMaximized() == _true);

  // Check if window is currently focused (only PLATFORM_DESKTOP)
  bool get isWindowFocused => (raylib.IsWindowFocused() == _true);

  // Check if window has been resized last frame
  bool get isWindowResized => (raylib.IsWindowResized() == _true);

  // Check if one specific window flag is enabled
  bool isWindowState(WindowConfigFlag flag) {
    var isSet = false;
    if (_configFlags[flag] != null) {
      isSet = (raylib.IsWindowState(_configFlags[flag]!) == _true);
    } else {
      throw ArgumentError.value(
          flag, 'flag', 'Does not map to any native window config flag.');
    }
    return isSet;
  }

  // Set window configuration state using flags
  void setWindowState(List<WindowConfigFlag> flags) {
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
  void clearWindowState(List<WindowConfigFlag> flags) {
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
  void toggleFullscreen() {
    raylib.ToggleFullscreen();
  }

  // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
  void maximizeWindow() {
    raylib.MaximizeWindow();
  }

  // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
  void minimizeWindow() {
    raylib.MinimizeWindow();
  }

  // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
  void restoreWindow() {
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
  void setWindowPosition(int x, int y) {
    raylib.SetWindowPosition(x, y);
  }

  // Set monitor for the current window (fullscreen mode)
  set windowMonitor(int monitor) => raylib.SetWindowMonitor(monitor);

  // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  void setWindowMinSize(int width, int height) {
    raylib.SetWindowMinSize(width, height);
  }

  // Set window dimensions
  void setWindowSize(int width, int height) {
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
  raylib_bind.Vector2 getMonitorPosition(int monitor) {
    return raylib.GetMonitorPosition(monitor);
  }

  // Get specified monitor width (max available by monitor)
  int getMonitorWidth(int monitor) {
    return raylib.GetMonitorWidth(monitor);
  }

  // Get specified monitor height (max available by monitor)
  int getMonitorHeight(int monitor) {
    return raylib.GetMonitorHeight(monitor);
  }

  // Get specified monitor physical width in millimetres
  int getMonitorPhysicalWidth(int monitor) {
    return raylib.GetMonitorPhysicalWidth(monitor);
  }

  // Get specified monitor physical height in millimetres
  int getMonitorPhysicalHeight(int monitor) {
    return raylib.GetMonitorPhysicalHeight(monitor);
  }

  // Get specified monitor refresh rate
  int getMonitorRefreshRate(int monitor) {
    return raylib.GetMonitorRefreshRate(monitor);
  }

  // Get window position XY on monitor
  raylib_bind.Vector2 get windowPosition => raylib.GetWindowPosition();

  // Get window scale DPI factor
  raylib_bind.Vector2 get windowScaleDPI => raylib.GetWindowScaleDPI();

  // Get the human-readable, UTF-8 encoded name of the primary monitor
  String getMonitorName(int monitor) {
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
    WindowConfigFlag.vsyncHint: raylib_bind.ConfigFlags.FLAG_VSYNC_HINT,
    WindowConfigFlag.fullScreenMode:
        raylib_bind.ConfigFlags.FLAG_FULLSCREEN_MODE,
    WindowConfigFlag.windowResizable:
        raylib_bind.ConfigFlags.FLAG_WINDOW_RESIZABLE,
    WindowConfigFlag.windowUndecorated:
        raylib_bind.ConfigFlags.FLAG_WINDOW_UNDECORATED,
    WindowConfigFlag.windowHidden: raylib_bind.ConfigFlags.FLAG_WINDOW_HIDDEN,
    WindowConfigFlag.windowMinimized:
        raylib_bind.ConfigFlags.FLAG_WINDOW_MINIMIZED,
    WindowConfigFlag.windowMaximized:
        raylib_bind.ConfigFlags.FLAG_WINDOW_MAXIMIZED,
    WindowConfigFlag.windowUnfocused:
        raylib_bind.ConfigFlags.FLAG_WINDOW_UNFOCUSED,
    WindowConfigFlag.windowTopmost: raylib_bind.ConfigFlags.FLAG_WINDOW_TOPMOST,
    WindowConfigFlag.windowAlwaysRun:
        raylib_bind.ConfigFlags.FLAG_WINDOW_ALWAYS_RUN,
    WindowConfigFlag.windowTransparent:
        raylib_bind.ConfigFlags.FLAG_WINDOW_TRANSPARENT,
    WindowConfigFlag.windowHighdpi: raylib_bind.ConfigFlags.FLAG_WINDOW_HIGHDPI,
    WindowConfigFlag.msaa_4XHint: raylib_bind.ConfigFlags.FLAG_MSAA_4X_HINT,
    WindowConfigFlag.interlacedHint:
        raylib_bind.ConfigFlags.FLAG_INTERLACED_HINT,
  };

  // **************** Cursor related APIs. ****************

  void showCursor() {
    raylib.ShowCursor();
  }

  // Hides cursor
  void hideCursor() {
    raylib.HideCursor();
  }

  // Check if cursor is not visible
  bool get isCursorHidden => (raylib.IsCursorHidden() == _true);

  // Enables cursor (unlock cursor)
  void enableCursor() {
    raylib.EnableCursor();
  }

  // Disables cursor (lock cursor)
  void disableCursor() {
    raylib.DisableCursor();
  }

  // Check if cursor is on the current screen.
  bool get isCursorOnScreen => (raylib.IsCursorOnScreen() == _true);

  // **************** Drawing related APIs. ****************

  // Set background color (framebuffer clear color)
  void clearBackground(raylib_bind.Color color) {
    raylib.ClearBackground(color);
  }

  // Setup canvas (framebuffer) to start drawing
  void beginDrawing() {
    raylib.BeginDrawing();
  }

  // End canvas drawing and swap buffers (double buffering)
  void endDrawing() {
    raylib.EndDrawing();
  }

  // Initialize 2D mode with custom camera (2D)
  void beginMode2D(raylib_bind.Camera2D camera) {
    raylib.BeginMode2D(camera);
  }

  // Ends 2D mode with custom camera
  void endMode2D() {
    raylib.EndMode2D();
  }

  // Initializes 3D mode with custom camera (3D)
  void beginMode3D(raylib_bind.Camera3D camera) {
    raylib.BeginMode3D(camera);
  }

  // Ends 3D mode and returns to default 2D orthographic mode
  void endMode3D() {
    raylib.EndMode3D();
  }

  // Initializes render texture for drawing
  void beginTextureMode(raylib_bind.RenderTexture target) {
    raylib.BeginTextureMode(target);
  }

  // Ends drawing to render texture
  void endTextureMode() {
    raylib.EndTextureMode();
  }

  // Begin custom shader drawing
  void beginShaderMode(raylib_bind.Shader shader) {
    raylib.BeginShaderMode(shader);
  }

  // End custom shader drawing (use default shader)
  void endShaderMode() {
    raylib.EndShaderMode();
  }

  // Begin blending mode (alpha, additive, multiplied)
  void beginBlendMode(int mode) {
    raylib.BeginBlendMode(mode);
  }

  // End blending mode (reset to default: alpha blending)
  void endBlendMode() {
    raylib.EndBlendMode();
  }

  // Begin scissor mode (define screen area for following drawing)
  void beginScissorMode(int x, int y, int width, int height) {
    raylib.BeginScissorMode(x, y, width, height);
  }

  // End scissor mode
  void endScissorMode() {
    raylib.EndScissorMode();
  }

  // Begin stereo rendering (requires VR simulator)
  void beginVrStereoMode(raylib_bind.VrStereoConfig config) {
    raylib.BeginVrStereoMode(config);
  }

  // End stereo rendering (requires VR simulator)
  void endVrStereoMode() {
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
  raylib_bind.VrStereoConfig loadVrStereoConfig(
      raylib_bind.VrDeviceInfo device) {
    return raylib.LoadVrStereoConfig(device);
  }

  // Unload VR stereo config
  void unloadVrStereoConfig(raylib_bind.VrStereoConfig config) {
    raylib.UnloadVrStereoConfig(config);
  }

  // **************** Struct constructors. ****************
  // Creates an object of Vector2
  raylib_bind.Vector2 createVector2(double x, double y) =>
      raylib.CreateVector2(x, y);

  // Creates an object of Color with given RGBA values.
  // Each channel showing be between 0-255.
  raylib_bind.Color createColor(int r, int g, int b, int a) =>
      raylib.CreateColor(r, g, b, a);
}

// Wrapper over raylib colors.
class _RaylibColor {
  late final raylib_bind.DartRaylib _raylib;

  _RaylibColor(raylib_bind.DartRaylib raylib) {
    _raylib = raylib;
  }

  // Creates an object of Color with given RGBA values.
  // Each channel showing be between 0-255.
  raylib_bind.Color fromRGBA(int r, int g, int b, int a) =>
      _raylib.CreateColor(r, g, b, a);

  // Light Gray
  raylib_bind.Color get lightGray => _raylib.CreateColor(200, 200, 200, 255);
  // Gray
  raylib_bind.Color get gray => _raylib.CreateColor(130, 130, 130, 255);
  // Dark Gray
  raylib_bind.Color get darkGray => _raylib.CreateColor(80, 80, 80, 255);
  // Yellow
  raylib_bind.Color get yellow => _raylib.CreateColor(253, 249, 0, 255);
  // Gold
  raylib_bind.Color get gold => _raylib.CreateColor(255, 203, 0, 255);
  // Orange
  raylib_bind.Color get orange => _raylib.CreateColor(255, 161, 0, 255);
  // Pink
  raylib_bind.Color get pink => _raylib.CreateColor(255, 109, 194, 255);
  // Red
  raylib_bind.Color get red => _raylib.CreateColor(230, 41, 55, 255);
  // Maroon
  raylib_bind.Color get maroon => _raylib.CreateColor(190, 33, 55, 255);
  // Green
  raylib_bind.Color get green => _raylib.CreateColor(0, 228, 48, 255);
  // Lime
  raylib_bind.Color get lime => _raylib.CreateColor(0, 158, 47, 255);
  // Dark Green
  raylib_bind.Color get darkGreen => _raylib.CreateColor(0, 117, 44, 255);
  // Sky Blue
  raylib_bind.Color get skyBlue => _raylib.CreateColor(102, 191, 255, 255);
  // Blue
  raylib_bind.Color get blue => _raylib.CreateColor(0, 121, 241, 255);
  // Dark Blue
  raylib_bind.Color get darkBlue => _raylib.CreateColor(0, 82, 172, 255);
  // Purple
  raylib_bind.Color get purple => _raylib.CreateColor(200, 122, 255, 255);
  // Violet
  raylib_bind.Color get violet => _raylib.CreateColor(135, 60, 190, 255);
  // Dark Purple
  raylib_bind.Color get darkPurple => _raylib.CreateColor(112, 31, 126, 255);
  // Beige
  raylib_bind.Color get beige => _raylib.CreateColor(211, 176, 131, 255);
  // Brown
  raylib_bind.Color get brown => _raylib.CreateColor(127, 106, 79, 255);
  // Dark Brown
  raylib_bind.Color get darkBrown => _raylib.CreateColor(76, 63, 47, 255);
  // White
  raylib_bind.Color get white => _raylib.CreateColor(255, 255, 255, 255);
  // Black
  raylib_bind.Color get black => _raylib.CreateColor(0, 0, 0, 255);
  // Blank (Transparent)
  raylib_bind.Color get blank => _raylib.CreateColor(0, 0, 0, 0);
  // Magenta
  raylib_bind.Color get magenta => _raylib.CreateColor(255, 0, 255, 255);
  // My own White (raylib logo)
  raylib_bind.Color get rayWhite => _raylib.CreateColor(245, 245, 245, 255);
}
