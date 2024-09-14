import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/type.dart';
import 'package:mirai/src/lang/mirai/types/qualified.dart';
import 'package:test/test.dart';

void testType() {
  test('fromParsed literal', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('null');
    expect(MiraiType.fromParsed(result.value),
        MiraiType.literal(MiraiLiteral(null)));
  });

  test('fromParsed qualified', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('AnType');
    expect(MiraiType.fromParsed(result.value),
        MiraiType.qualified(MiraiQualified(['AnType'])));
  });

  test('fromParsed literal - 1 argument', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('null<A>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.literal(MiraiLiteral(null), [
          MiraiType.qualified(MiraiQualified(['A']))
        ]));
  });

  test('fromParsed qualified - 1 argument', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('AnType<B>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.qualified(MiraiQualified(['AnType']), [
          MiraiType.qualified(MiraiQualified(['B']))
        ]));
  });

  test('fromParsed literal - 2 arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('null<A, true>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.literal(MiraiLiteral(null), [
          MiraiType.qualified(MiraiQualified(['A'])),
          MiraiType.literal(MiraiLiteral.bool(true)),
        ]));
  });

  test('fromParsed qualified - 2 arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('AnType<B, 1>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.qualified(MiraiQualified(['AnType']), [
          MiraiType.qualified(MiraiQualified(['B'])),
          MiraiType.literal(MiraiLiteral.num(1)),
        ]));
  });

  test('fromParsed literal - 3 arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('null<A, true, "Hello">');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.literal(MiraiLiteral(null), [
          MiraiType.qualified(MiraiQualified(['A'])),
          MiraiType.literal(MiraiLiteral.bool(true)),
          MiraiType.literal(MiraiLiteral.string('Hello')),
        ]));
  });

  test('fromParsed qualified - 3 arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('AnType<B, 1, .abc>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.qualified(MiraiQualified(['AnType']), [
          MiraiType.qualified(MiraiQualified(['B'])),
          MiraiType.literal(MiraiLiteral.int(1)),
          MiraiType.literal(MiraiLiteral.enumLiteral(MiraiQualified(['abc']))),
        ]));
  });
}

void main() {
  testType();
}
