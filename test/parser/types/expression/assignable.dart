import 'package:mirai/src/lang/mirai/types/expression/assignable.dart';
import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/primary.dart';
import 'package:mirai/src/lang/mirai/types/selector.dart';
import 'package:mirai/src/lang/mirai/types/type.dart';
import 'package:mirai/src/lang/mirai/types/qualified.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testAssignableExpression() {
  test('fromParsed variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('value');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression(MiraiPrimary.identifier('value')));
  });

  test('fromParsed variable item', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('value[1]');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression(MiraiPrimary.identifier('value')));
  });

  test('fromParsed function call', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('myFunction(1, 2, 3)');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableExpression(MiraiPrimary.constructClass(
            MiraiConstructClass(
                MiraiType.qualified(MiraiQualified(['myFunction'])), [
          MiraiExpression(
              assignable: MiraiAssignableExpression(
                  MiraiPrimary.literal(MiraiLiteral.int(1)))),
          MiraiExpression(
              assignable: MiraiAssignableExpression(
                  MiraiPrimary.literal(MiraiLiteral.int(2)))),
          MiraiExpression(
              assignable: MiraiAssignableExpression(
                  MiraiPrimary.literal(MiraiLiteral.int(3))))
        ]))));
  });

  test('fromParsed call list item', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('myFunction[1](2, 3, 4)');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableExpression(MiraiPrimary.identifier('myFunction'), [
          MiraiAssignableSelector.key(MiraiExpression(
              assignable: MiraiAssignableExpression(
                  MiraiPrimary.literal(MiraiLiteral.int(1)), []))),
          [
            MiraiArgument(
                MiraiExpression(
                    assignable: MiraiAssignableExpression(
                        MiraiPrimary.literal(MiraiLiteral.int(2)), [])),
                null),
            MiraiArgument(
                MiraiExpression(
                    assignable: MiraiAssignableExpression(
                        MiraiPrimary.literal(MiraiLiteral.int(3)), [])),
                null),
            MiraiArgument(
                MiraiExpression(
                    assignable: MiraiAssignableExpression(
                        MiraiPrimary.literal(MiraiLiteral.int(4)), [])),
                null)
          ]
        ]));
  });

  test('fromParsed super list', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('super[0]');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(
        parsed, MiraiAssignableExpression(MiraiPrimary.assignableSuper(null)));
  });
}

void main() {
  testAssignableExpression();
}
