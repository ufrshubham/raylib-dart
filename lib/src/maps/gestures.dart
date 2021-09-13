part of '../modules/core.dart';

/// Maps user facing [Gesture] to native [raylib_bind.Gesture]
const Map<Gesture, int> _gestures = {
  Gesture.none: raylib_bind.Gestures.GESTURE_NONE,
  Gesture.tap: raylib_bind.Gestures.GESTURE_TAP,
  Gesture.doubletap: raylib_bind.Gestures.GESTURE_DOUBLETAP,
  Gesture.hold: raylib_bind.Gestures.GESTURE_HOLD,
  Gesture.drag: raylib_bind.Gestures.GESTURE_DRAG,
  Gesture.swipeRight: raylib_bind.Gestures.GESTURE_SWIPE_RIGHT,
  Gesture.swipeLeft: raylib_bind.Gestures.GESTURE_SWIPE_LEFT,
  Gesture.swipeUp: raylib_bind.Gestures.GESTURE_SWIPE_UP,
  Gesture.swipeDown: raylib_bind.Gestures.GESTURE_SWIPE_DOWN,
  Gesture.pinchIn: raylib_bind.Gestures.GESTURE_PINCH_IN,
  Gesture.pinchOut: raylib_bind.Gestures.GESTURE_PINCH_OUT,
};
