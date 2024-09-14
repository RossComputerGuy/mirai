import 'package:test/test.dart';
import 'parser/types.dart' hide main;

void testParser() {
  group('Type', testTypes);
}

void main() {
  testParser();
}
