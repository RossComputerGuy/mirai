import 'package:test/test.dart';
import 'parser.dart' hide main;
import 'target.dart' hide main;

void main() {
  group('Parser', testParser);
  group('Target', testTarget);
}
