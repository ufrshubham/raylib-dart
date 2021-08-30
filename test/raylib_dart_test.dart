import 'package:raylib_dart/raylib_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Library loading tests', () {
    test('Raylib load test', () {
      expect(() {
        Raylib();
      }, returnsNormally);
    });
  });

  group('Module init tests', () {
    late Raylib raylib;

    setUp(() {
      raylib = Raylib();
    });

    test('Core module init test', () {
      expect(() {
        raylib.core;
      }, returnsNormally);
    });
  });
}
