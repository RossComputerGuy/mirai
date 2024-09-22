import 'package:mirai/src/lang/mirai/types/expression/assignable.dart';
import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/types/primary.dart';
import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/selector.dart';
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

  test('fromParsed assignable selector', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('value[1]');
    final parsed = MiraiExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiExpression(
            assignable:
                MiraiAssignableExpression(MiraiPrimary.identifier('value'), [
          MiraiAssignableSelector.key(MiraiExpression(
              assignable: MiraiAssignableExpression(
                  MiraiPrimary.literal(MiraiLiteral.int(1))))),
        ])));
  });

  test('fromParsed pointer of variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('&value');
    final parsed = MiraiExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiExpression(
            assignable: MiraiAssignableExpression(
                MiraiPrimary.identifier('value'), [])));
  });

  test('fromParsed assignment', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.expression());
    final result = parser.parse('value = 1');
    final parsed = MiraiExpression.fromParsed(result.value);

    print(parsed);
  });
}

void main() {
  testExpression();
}
