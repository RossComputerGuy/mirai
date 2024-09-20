import 'package:mirai/src/lang/mirai/types/expression/assignable.dart';
import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/types/primary.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

import 'expression/assignable.dart' hide main;

void testExpression() {
  group('Assignable', testAssignableExpression);

  test('fromParsed assignable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('value');
    final parsed = MiraiExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiExpression(
            assignable: MiraiAssignableExpression(
                MiraiPrimary.identifier('value'), [])));
  });

  test('fromParsed pointer of variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('&value');
    final parsed = MiraiExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiExpression(
            isPointer: true,
            assignable: MiraiAssignableExpression(
                MiraiPrimary.identifier('value'), [])));
  });
}

void main() {
  testExpression();
}
