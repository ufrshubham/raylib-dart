part of '../modules/core.dart';

/// Maps user facing [MouseCursor] to native [raylib_bind.MouseCursor]
const Map<MouseCursor, int> _mouseCursor = {
  MouseCursor.defaultCursor: raylib_bind.MouseCursor.MOUSE_CURSOR_DEFAULT,
  MouseCursor.arrow: raylib_bind.MouseCursor.MOUSE_CURSOR_ARROW,
  MouseCursor.ibeam: raylib_bind.MouseCursor.MOUSE_CURSOR_IBEAM,
  MouseCursor.crosshair: raylib_bind.MouseCursor.MOUSE_CURSOR_CROSSHAIR,
  MouseCursor.pointingHand: raylib_bind.MouseCursor.MOUSE_CURSOR_POINTING_HAND,
  MouseCursor.resizeEw: raylib_bind.MouseCursor.MOUSE_CURSOR_RESIZE_EW,
  MouseCursor.resizeNs: raylib_bind.MouseCursor.MOUSE_CURSOR_RESIZE_NS,
  MouseCursor.resizeNwse: raylib_bind.MouseCursor.MOUSE_CURSOR_RESIZE_NWSE,
  MouseCursor.resizeNesw: raylib_bind.MouseCursor.MOUSE_CURSOR_RESIZE_NESW,
  MouseCursor.resizeAll: raylib_bind.MouseCursor.MOUSE_CURSOR_RESIZE_ALL,
  MouseCursor.notAllowed: raylib_bind.MouseCursor.MOUSE_CURSOR_NOT_ALLOWED,
};
