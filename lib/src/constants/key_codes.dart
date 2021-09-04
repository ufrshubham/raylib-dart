enum KeyboardKeyCode {
  // Alphanumeric keys
  apostrophe,
  comma,
  minus,
  period,
  slash,
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  semicolon,
  equal,
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  m,
  n,
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v,
  w,
  x,
  y,
  z,

  // Function keys
  space,
  escape,
  enter,
  tab,
  backspace,
  insert,
  delete,
  right,
  left,
  down,
  up,
  pageUp,
  pageDown,
  home,
  end,
  capsLock,
  scrollLock,
  numLock,
  printScreen,
  pause,
  f1,
  f2,
  f3,
  f4,
  f5,
  f6,
  f7,
  f8,
  f9,
  f10,
  f11,
  f12,
  leftShift,
  leftControl,
  leftAlt,
  leftSuper,
  rightShift,
  rightControl,
  rightAlt,
  rightSuper,
  kbMenu,
  leftBracket,
  backslash,
  rightBracket,
  grave,

  // Keypad keys
  keyPad0,
  keyPad1,
  keyPad2,
  keyPad3,
  keyPad4,
  keyPad5,
  keyPad6,
  keyPad7,
  keyPad8,
  keyPad9,
  keyPadDecimal,
  keyPadDivide,
  keyPadMultiply,
  keyPadSubtract,
  keyPadAdd,
  keyPadEnter,
  keyPadEqual,

  // Android key buttons
  androidBack,
  androidMenu,
  androidVolumeUp,
  androidVolumeDown,
}

enum MouseButtonCode {
  mouseLeftButton,
  mouseRightButton,
  mouseMiddleButton,
}

enum GamepadButtonCode {
  // This is normally a DPAD
  leftFaceUp,
  leftFaceRight,
  leftFaceDown,
  leftFaceLeft,

  // This normally corresponds with PlayStation and Xbox controllers
  // XBOX: [Y,X,A,B]
  // PS3: [Triangle,Square,Cross,Circle]
  // No support for 6 button controllers though..
  rightFaceUp,
  rightFaceRight,
  rightFaceDown,
  rightFaceLeft,

  // Triggers
  leftTrigger1,
  leftTrigger2,
  rightTrigger1,
  rightTrigger2,

  // These are buttons in the center of the gamepad
  middleLeft, // PS3 Select
  middle, // PS Button/XBOX Button
  middleRight, // PS3 Start

  // These are the joystick press in buttons
  leftThumb,
  lightThumb,
}

enum GamepadAxisCode {
  // Left stick
  leftX,
  leftY,

  // Right stick
  rightX,
  rightY,

  // Pressure levels for the back triggers
  leftTrigger, // [1..-1] (pressure-level)
  rightTrigger, // [1..-1] (pressure-level)
}
