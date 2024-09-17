import 'package:test/test.dart';
import 'types/import.dart' hide main;
import 'types/literal.dart' hide main;
import 'types/type.dart' hide main;
import 'types/qualified.dart' hide main;
import 'types/statement.dart' hide main;

void testTypes() {
  group('Import', testImport);
  group('Literal', testLiteral);
  group('Statement', testStatement);
  group('Type', testType);
  group('Qualified', testQualified);
}

void main() {
  testTypes();
}
