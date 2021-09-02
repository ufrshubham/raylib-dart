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
}
