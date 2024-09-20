import 'package:mirai/src/lang/mirai/types/expression/assignable.dart';
import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/types/null_safety.dart';
import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/primary.dart';
import 'package:mirai/src/lang/mirai/types/selector.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testAssignableSelector() {
  test('fromParsed list', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[0]');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(MiraiExpression(
            assignable: MiraiAssignableExpression(
                MiraiPrimary.literal(MiraiLiteral(MiraiNumber(0)))))));
  });

  test('fromParsed list with null safety optional', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[0]?');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(
            MiraiExpression(
                assignable: MiraiAssignableExpression(
                    MiraiPrimary.literal(MiraiLiteral(MiraiNumber(0))))),
            nullSafety: MiraiNullSafetyAnnotation.optional()));
  });

  test('fromParsed list with null safety not', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[0]!');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(
            MiraiExpression(
                assignable: MiraiAssignableExpression(
                    MiraiPrimary.literal(MiraiLiteral(MiraiNumber(0))))),
            nullSafety: MiraiNullSafetyAnnotation.not()));
  });

  test('fromParsed map', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[\"A\"]');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(MiraiExpression(
            assignable: MiraiAssignableExpression(
                MiraiPrimary.literal(MiraiLiteral(MiraiString('A')))))));
  });

  test('fromParsed map with null safety optional', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[\"A\"]?');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(
            MiraiExpression(
                assignable: MiraiAssignableExpression(
                    MiraiPrimary.literal(MiraiLiteral(MiraiString('A'))))),
            nullSafety: MiraiNullSafetyAnnotation.optional()));
  });

  test('fromParsed map with null safety not', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('[\"A\"]!');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(
        parsed,
        MiraiAssignableSelector.key(
            MiraiExpression(
                assignable: MiraiAssignableExpression(
                    MiraiPrimary.literal(MiraiLiteral(MiraiString('A'))))),
            nullSafety: MiraiNullSafetyAnnotation.not()));
  });

  test('fromParsed .identifier', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableSelector());
    final result = parser.parse('.abc');
    final parsed = MiraiAssignableSelector.fromParsed(result.value);

    expect(parsed, MiraiAssignableSelector.identifier('abc'));
  });
}

void testSelector() {
  group('Assignable', testAssignableSelector);
}

void main() {
  testSelector();
}
