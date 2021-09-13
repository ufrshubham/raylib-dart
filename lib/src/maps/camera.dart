part of '../modules/core.dart';

/// Maps user facing [CameraMode] to native [raylib_bind.CameraMode]
const Map<CameraMode, int> _cameraModes = {
  CameraMode.custom: raylib_bind.CameraMode.CAMERA_CUSTOM,
  CameraMode.free: raylib_bind.CameraMode.CAMERA_FREE,
  CameraMode.orbital: raylib_bind.CameraMode.CAMERA_ORBITAL,
  CameraMode.firstPerson: raylib_bind.CameraMode.CAMERA_FIRST_PERSON,
  CameraMode.thirdPerson: raylib_bind.CameraMode.CAMERA_THIRD_PERSON,
};

/// Maps user facing [CameraProjection] to native [raylib_bind.CameraProjection]
const Map<CameraProjection, int> _cameraProjections = {
  CameraProjection.perspective: raylib_bind.CameraProjection.CAMERA_PERSPECTIVE,
  CameraProjection.orthographic:
      raylib_bind.CameraProjection.CAMERA_ORTHOGRAPHIC,
};
