import 'package:test/test.dart';
import 'types/expression.dart' hide main;
import 'types/import.dart' hide main;
import 'types/literal.dart' hide main;
import 'types/operator.dart' hide main;
import 'types/primary.dart' hide main;
import 'types/qualified.dart' hide main;
import 'types/selector.dart' hide main;
import 'types/statement.dart' hide main;
import 'types/type.dart' hide main;

void testTypes() {
  group('Expression', testExpression);
  group('Import', testImport);
  group('Literal', testLiteral);
  group('Operator', testOperator);
  group('Primary', testPrimary);
  group('Qualified', testQualified);
  group('Selector', testSelector);
  group('Statement', testStatement);
  group('Type', testType);
}

void main() {
  testTypes();
}
