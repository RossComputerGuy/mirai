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
    final parsed = MiraiType.fromParsed(result.value);

    expect(parsed, MiraiType.literal(MiraiLiteral(null)));
    expect(parsed.isTypeLiteral, true);
    expect(parsed.toString(), 'MiraiType(MiraiLiteral(null))');
    expect(parsed.asLiteral, MiraiLiteral(null));
  });

  test('fromParsed qualified', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.type());
    final result = parser.parse('AnType');
    final parsed = MiraiType.fromParsed(result.value);

    expect(parsed, MiraiType.qualified(MiraiQualified(['AnType'])));
    expect(parsed.isTypeQualified, true);
    expect(parsed.asQualified, MiraiQualified(['AnType']));
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
    final result = parser.parse('AnType<1, 12.3, .abc>');
    expect(
        MiraiType.fromParsed(result.value),
        MiraiType.qualified(MiraiQualified(['AnType']), [
          MiraiType.literal(MiraiLiteral.int(1)),
          MiraiType.literal(MiraiLiteral.double(12.3)),
          MiraiType.literal(MiraiLiteral.enumLiteral(MiraiQualified(['abc']))),
        ]));
  });
}

void main() {
  testType();
}
