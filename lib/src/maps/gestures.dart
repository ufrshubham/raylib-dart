part of '../modules/core.dart';

/// Maps user facing [Gesture] to native [raylib_bind.Gesture]
const Map<Gesture, int> _gestures = {
  Gesture.none: raylib_bind.Gesture.GESTURE_NONE,
  Gesture.tap: raylib_bind.Gesture.GESTURE_TAP,
  Gesture.doubletap: raylib_bind.Gesture.GESTURE_DOUBLETAP,
  Gesture.hold: raylib_bind.Gesture.GESTURE_HOLD,
  Gesture.drag: raylib_bind.Gesture.GESTURE_DRAG,
  Gesture.swipeRight: raylib_bind.Gesture.GESTURE_SWIPE_RIGHT,
  Gesture.swipeLeft: raylib_bind.Gesture.GESTURE_SWIPE_LEFT,
  Gesture.swipeUp: raylib_bind.Gesture.GESTURE_SWIPE_UP,
  Gesture.swipeDown: raylib_bind.Gesture.GESTURE_SWIPE_DOWN,
  Gesture.pinchIn: raylib_bind.Gesture.GESTURE_PINCH_IN,
  Gesture.pinchOut: raylib_bind.Gesture.GESTURE_PINCH_OUT,
};
