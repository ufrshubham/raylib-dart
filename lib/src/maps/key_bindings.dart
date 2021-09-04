part of '../modules/core.dart';

/// Maps user facing [WindowConfigFlag] to native [raylib_bind.ConfigFlags]
const Map<WindowConfigFlag, int> _configFlags = {
  WindowConfigFlag.vsyncHint: raylib_bind.ConfigFlags.FLAG_VSYNC_HINT,
  WindowConfigFlag.fullScreenMode: raylib_bind.ConfigFlags.FLAG_FULLSCREEN_MODE,
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
  WindowConfigFlag.interlacedHint: raylib_bind.ConfigFlags.FLAG_INTERLACED_HINT,
};

/// Maps user facing [KeyboardKeyCode] to native [raylib_bind.KeyboardKey]
const Map<KeyboardKeyCode, int> _keyboardKeys = {
  KeyboardKeyCode.apostrophe: raylib_bind.KeyboardKey.KEY_APOSTROPHE,
  KeyboardKeyCode.comma: raylib_bind.KeyboardKey.KEY_COMMA,
  KeyboardKeyCode.minus: raylib_bind.KeyboardKey.KEY_MINUS,
  KeyboardKeyCode.period: raylib_bind.KeyboardKey.KEY_PERIOD,
  KeyboardKeyCode.slash: raylib_bind.KeyboardKey.KEY_SLASH,
  KeyboardKeyCode.zero: raylib_bind.KeyboardKey.KEY_ZERO,
  KeyboardKeyCode.one: raylib_bind.KeyboardKey.KEY_ONE,
  KeyboardKeyCode.two: raylib_bind.KeyboardKey.KEY_TWO,
  KeyboardKeyCode.three: raylib_bind.KeyboardKey.KEY_THREE,
  KeyboardKeyCode.four: raylib_bind.KeyboardKey.KEY_FOUR,
  KeyboardKeyCode.five: raylib_bind.KeyboardKey.KEY_FIVE,
  KeyboardKeyCode.six: raylib_bind.KeyboardKey.KEY_SIX,
  KeyboardKeyCode.seven: raylib_bind.KeyboardKey.KEY_SEVEN,
  KeyboardKeyCode.eight: raylib_bind.KeyboardKey.KEY_EIGHT,
  KeyboardKeyCode.nine: raylib_bind.KeyboardKey.KEY_NINE,
  KeyboardKeyCode.semicolon: raylib_bind.KeyboardKey.KEY_SEMICOLON,
  KeyboardKeyCode.equal: raylib_bind.KeyboardKey.KEY_EQUAL,
  KeyboardKeyCode.a: raylib_bind.KeyboardKey.KEY_A,
  KeyboardKeyCode.b: raylib_bind.KeyboardKey.KEY_B,
  KeyboardKeyCode.c: raylib_bind.KeyboardKey.KEY_C,
  KeyboardKeyCode.d: raylib_bind.KeyboardKey.KEY_D,
  KeyboardKeyCode.e: raylib_bind.KeyboardKey.KEY_E,
  KeyboardKeyCode.f: raylib_bind.KeyboardKey.KEY_F,
  KeyboardKeyCode.g: raylib_bind.KeyboardKey.KEY_G,
  KeyboardKeyCode.h: raylib_bind.KeyboardKey.KEY_H,
  KeyboardKeyCode.i: raylib_bind.KeyboardKey.KEY_I,
  KeyboardKeyCode.j: raylib_bind.KeyboardKey.KEY_J,
  KeyboardKeyCode.k: raylib_bind.KeyboardKey.KEY_K,
  KeyboardKeyCode.l: raylib_bind.KeyboardKey.KEY_L,
  KeyboardKeyCode.m: raylib_bind.KeyboardKey.KEY_M,
  KeyboardKeyCode.n: raylib_bind.KeyboardKey.KEY_N,
  KeyboardKeyCode.o: raylib_bind.KeyboardKey.KEY_O,
  KeyboardKeyCode.p: raylib_bind.KeyboardKey.KEY_P,
  KeyboardKeyCode.q: raylib_bind.KeyboardKey.KEY_Q,
  KeyboardKeyCode.r: raylib_bind.KeyboardKey.KEY_R,
  KeyboardKeyCode.s: raylib_bind.KeyboardKey.KEY_S,
  KeyboardKeyCode.t: raylib_bind.KeyboardKey.KEY_T,
  KeyboardKeyCode.u: raylib_bind.KeyboardKey.KEY_U,
  KeyboardKeyCode.v: raylib_bind.KeyboardKey.KEY_V,
  KeyboardKeyCode.w: raylib_bind.KeyboardKey.KEY_W,
  KeyboardKeyCode.x: raylib_bind.KeyboardKey.KEY_X,
  KeyboardKeyCode.y: raylib_bind.KeyboardKey.KEY_Y,
  KeyboardKeyCode.z: raylib_bind.KeyboardKey.KEY_Z,
  KeyboardKeyCode.space: raylib_bind.KeyboardKey.KEY_SPACE,
  KeyboardKeyCode.escape: raylib_bind.KeyboardKey.KEY_ESCAPE,
  KeyboardKeyCode.enter: raylib_bind.KeyboardKey.KEY_ENTER,
  KeyboardKeyCode.tab: raylib_bind.KeyboardKey.KEY_TAB,
  KeyboardKeyCode.backspace: raylib_bind.KeyboardKey.KEY_BACKSPACE,
  KeyboardKeyCode.insert: raylib_bind.KeyboardKey.KEY_INSERT,
  KeyboardKeyCode.delete: raylib_bind.KeyboardKey.KEY_DELETE,
  KeyboardKeyCode.right: raylib_bind.KeyboardKey.KEY_RIGHT,
  KeyboardKeyCode.left: raylib_bind.KeyboardKey.KEY_LEFT,
  KeyboardKeyCode.down: raylib_bind.KeyboardKey.KEY_DOWN,
  KeyboardKeyCode.up: raylib_bind.KeyboardKey.KEY_UP,
  KeyboardKeyCode.pageUp: raylib_bind.KeyboardKey.KEY_PAGE_UP,
  KeyboardKeyCode.pageDown: raylib_bind.KeyboardKey.KEY_PAGE_DOWN,
  KeyboardKeyCode.home: raylib_bind.KeyboardKey.KEY_HOME,
  KeyboardKeyCode.end: raylib_bind.KeyboardKey.KEY_END,
  KeyboardKeyCode.capsLock: raylib_bind.KeyboardKey.KEY_CAPS_LOCK,
  KeyboardKeyCode.scrollLock: raylib_bind.KeyboardKey.KEY_SCROLL_LOCK,
  KeyboardKeyCode.numLock: raylib_bind.KeyboardKey.KEY_NUM_LOCK,
  KeyboardKeyCode.printScreen: raylib_bind.KeyboardKey.KEY_PRINT_SCREEN,
  KeyboardKeyCode.pause: raylib_bind.KeyboardKey.KEY_PAUSE,
  KeyboardKeyCode.f1: raylib_bind.KeyboardKey.KEY_F1,
  KeyboardKeyCode.f2: raylib_bind.KeyboardKey.KEY_F2,
  KeyboardKeyCode.f3: raylib_bind.KeyboardKey.KEY_F3,
  KeyboardKeyCode.f4: raylib_bind.KeyboardKey.KEY_F4,
  KeyboardKeyCode.f5: raylib_bind.KeyboardKey.KEY_F5,
  KeyboardKeyCode.f6: raylib_bind.KeyboardKey.KEY_F6,
  KeyboardKeyCode.f7: raylib_bind.KeyboardKey.KEY_F7,
  KeyboardKeyCode.f8: raylib_bind.KeyboardKey.KEY_F8,
  KeyboardKeyCode.f9: raylib_bind.KeyboardKey.KEY_F9,
  KeyboardKeyCode.f10: raylib_bind.KeyboardKey.KEY_F10,
  KeyboardKeyCode.f11: raylib_bind.KeyboardKey.KEY_F11,
  KeyboardKeyCode.f12: raylib_bind.KeyboardKey.KEY_F12,
  KeyboardKeyCode.leftShift: raylib_bind.KeyboardKey.KEY_LEFT_SHIFT,
  KeyboardKeyCode.leftControl: raylib_bind.KeyboardKey.KEY_LEFT_CONTROL,
  KeyboardKeyCode.leftAlt: raylib_bind.KeyboardKey.KEY_LEFT_ALT,
  KeyboardKeyCode.leftSuper: raylib_bind.KeyboardKey.KEY_LEFT_SUPER,
  KeyboardKeyCode.rightShift: raylib_bind.KeyboardKey.KEY_RIGHT_SHIFT,
  KeyboardKeyCode.rightControl: raylib_bind.KeyboardKey.KEY_RIGHT_CONTROL,
  KeyboardKeyCode.rightAlt: raylib_bind.KeyboardKey.KEY_RIGHT_ALT,
  KeyboardKeyCode.rightSuper: raylib_bind.KeyboardKey.KEY_RIGHT_SUPER,
  KeyboardKeyCode.kbMenu: raylib_bind.KeyboardKey.KEY_KB_MENU,
  KeyboardKeyCode.leftBracket: raylib_bind.KeyboardKey.KEY_LEFT_BRACKET,
  KeyboardKeyCode.backslash: raylib_bind.KeyboardKey.KEY_BACKSLASH,
  KeyboardKeyCode.rightBracket: raylib_bind.KeyboardKey.KEY_RIGHT_BRACKET,
  KeyboardKeyCode.grave: raylib_bind.KeyboardKey.KEY_GRAVE,
  KeyboardKeyCode.keyPad0: raylib_bind.KeyboardKey.KEY_KP_0,
  KeyboardKeyCode.keyPad1: raylib_bind.KeyboardKey.KEY_KP_1,
  KeyboardKeyCode.keyPad2: raylib_bind.KeyboardKey.KEY_KP_2,
  KeyboardKeyCode.keyPad3: raylib_bind.KeyboardKey.KEY_KP_3,
  KeyboardKeyCode.keyPad4: raylib_bind.KeyboardKey.KEY_KP_4,
  KeyboardKeyCode.keyPad5: raylib_bind.KeyboardKey.KEY_KP_5,
  KeyboardKeyCode.keyPad6: raylib_bind.KeyboardKey.KEY_KP_6,
  KeyboardKeyCode.keyPad7: raylib_bind.KeyboardKey.KEY_KP_7,
  KeyboardKeyCode.keyPad8: raylib_bind.KeyboardKey.KEY_KP_8,
  KeyboardKeyCode.keyPad9: raylib_bind.KeyboardKey.KEY_KP_9,
  KeyboardKeyCode.keyPadDecimal: raylib_bind.KeyboardKey.KEY_KP_DECIMAL,
  KeyboardKeyCode.keyPadDivide: raylib_bind.KeyboardKey.KEY_KP_DIVIDE,
  KeyboardKeyCode.keyPadMultiply: raylib_bind.KeyboardKey.KEY_KP_MULTIPLY,
  KeyboardKeyCode.keyPadSubtract: raylib_bind.KeyboardKey.KEY_KP_SUBTRACT,
  KeyboardKeyCode.keyPadAdd: raylib_bind.KeyboardKey.KEY_KP_ADD,
  KeyboardKeyCode.keyPadEnter: raylib_bind.KeyboardKey.KEY_KP_ENTER,
  KeyboardKeyCode.keyPadEqual: raylib_bind.KeyboardKey.KEY_KP_EQUAL,
  KeyboardKeyCode.androidBack: raylib_bind.KeyboardKey.KEY_BACK,
  KeyboardKeyCode.androidMenu: raylib_bind.KeyboardKey.KEY_MENU,
  KeyboardKeyCode.androidVolumeUp: raylib_bind.KeyboardKey.KEY_VOLUME_UP,
  KeyboardKeyCode.androidVolumeDown: raylib_bind.KeyboardKey.KEY_VOLUME_DOWN,
};

/// Maps user facing [MouseButtonCode] to native [raylib_bind.MouseButton>]
const Map<MouseButtonCode, int> _mouseButtons = {
  MouseButtonCode.mouseLeftButton: raylib_bind.MouseButton.MOUSE_LEFT_BUTTON,
  MouseButtonCode.mouseRightButton: raylib_bind.MouseButton.MOUSE_RIGHT_BUTTON,
  MouseButtonCode.mouseMiddleButton:
      raylib_bind.MouseButton.MOUSE_MIDDLE_BUTTON,
};

/// Maps user facing [GamepadButtonCode] to native [raylib_bind.GamepadButton]
const Map<GamepadButtonCode, int> _gamepadButtons = {
  GamepadButtonCode.leftFaceUp:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_FACE_UP,
  GamepadButtonCode.leftFaceRight:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_FACE_RIGHT,
  GamepadButtonCode.leftFaceDown:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_FACE_DOWN,
  GamepadButtonCode.leftFaceLeft:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_FACE_LEFT,
  GamepadButtonCode.rightFaceUp:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_FACE_UP,
  GamepadButtonCode.rightFaceRight:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,
  GamepadButtonCode.rightFaceDown:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_FACE_DOWN,
  GamepadButtonCode.rightFaceLeft:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_FACE_LEFT,
  GamepadButtonCode.leftTrigger1:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_TRIGGER_1,
  GamepadButtonCode.leftTrigger2:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_TRIGGER_2,
  GamepadButtonCode.rightTrigger1:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_TRIGGER_1,
  GamepadButtonCode.rightTrigger2:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_TRIGGER_2,
  GamepadButtonCode.middleLeft:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_MIDDLE_LEFT,
  GamepadButtonCode.middle: raylib_bind.GamepadButton.GAMEPAD_BUTTON_MIDDLE,
  GamepadButtonCode.middleRight:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_MIDDLE_RIGHT,
  GamepadButtonCode.leftThumb:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_LEFT_THUMB,
  GamepadButtonCode.lightThumb:
      raylib_bind.GamepadButton.GAMEPAD_BUTTON_RIGHT_THUMB,
};

/// Maps user facing [GamepadAxisCode] to native [raylib_bind.GamepadAxis]
const Map<GamepadAxisCode, int> _gamepadAxis = {
  GamepadAxisCode.leftX: raylib_bind.GamepadAxis.GAMEPAD_AXIS_LEFT_X,
  GamepadAxisCode.leftY: raylib_bind.GamepadAxis.GAMEPAD_AXIS_LEFT_Y,
  GamepadAxisCode.rightX: raylib_bind.GamepadAxis.GAMEPAD_AXIS_RIGHT_X,
  GamepadAxisCode.rightY: raylib_bind.GamepadAxis.GAMEPAD_AXIS_RIGHT_Y,
  GamepadAxisCode.leftTrigger:
      raylib_bind.GamepadAxis.GAMEPAD_AXIS_LEFT_TRIGGER,
  GamepadAxisCode.rightTrigger:
      raylib_bind.GamepadAxis.GAMEPAD_AXIS_RIGHT_TRIGGER,
};
