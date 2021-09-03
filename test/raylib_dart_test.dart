import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as path;
import 'package:raylib_dart/raylib_dart.dart';

void main() {
  final raylibPath = path.join(
      Directory.current.path, 'vendors/raylib/build/raylib/Release/raylib.dll');

  group('Library loading tests', () {
    test('Raylib load test', () {
      expect(() {
        Raylib(raylibPath);
      }, returnsNormally);
    });
  });

  group('Module init tests', () {
    late Raylib raylib;

    setUp(() {
      raylib = Raylib(raylibPath);
    });

    test('Core module init test', () {
      expect(() {
        raylib.core;
      }, returnsNormally);
    });
  });

  group('Struct constructors test', () {
    late Raylib raylib;

    setUp(() {
      raylib = Raylib(raylibPath);
    });

    test('Create Vector2', () {
      double x = 100.0;
      double y = 200.0;

      final vector = raylib.core.createVector2(x, y);

      expect(vector.x, equals(x));
      expect(vector.y, equals(y));
    });

    test('Create Color', () {
      final color = raylib.core.createColor(
        raylib.core.colors.darkBlue.r,
        raylib.core.colors.darkBlue.g,
        raylib.core.colors.darkBlue.b,
        raylib.core.colors.darkBlue.a,
      );

      expect(color.r, equals(raylib.core.colors.darkBlue.r));
      expect(color.g, equals(raylib.core.colors.darkBlue.g));
      expect(color.b, equals(raylib.core.colors.darkBlue.b));
      expect(color.a, equals(raylib.core.colors.darkBlue.a));
    });
  });
}
