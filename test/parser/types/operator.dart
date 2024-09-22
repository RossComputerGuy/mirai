import 'package:mirai/src/lang/mirai/types/operator.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testOperator() {
  test('fromParsed assign', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignmentOperator());
    final result = parser.parse('=');
    final parsed = MiraiAssignmentOperator.fromParsed(result.value);

    expect(parsed, MiraiAssignmentOperator.assign);
  });

  test('fromParsed multiply', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignmentOperator());
    final result = parser.parse('*=');
    final parsed = MiraiAssignmentOperator.fromParsed(result.value);

    expect(parsed, MiraiAssignmentOperator.multiply);
  });
}

void main() {
  testOperator();
}
