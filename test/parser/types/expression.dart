import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

import 'expression/assignable.dart' hide main;

void testExpression() {
  group('Assignable', testAssignableExpression);

  test('fromParsed assignable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('value');
    final parsed = MiraiExpression.fromParsed(result.value);
  });

  test('fromParsed pointer of variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('&value');
    final parsed = MiraiExpression.fromParsed(result.value);

    expect(parsed, MiraiExpression(isPointer: true));
  });
}

void main() {
  testExpression();
}
