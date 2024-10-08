import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/qualified.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:petitparser/petitparser.dart';
import 'package:test/test.dart';

void testLiteral() {
  test('fromParsed null', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('null');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed, MiraiLiteral(null));
    expect(parsed.isNull, true);
  });

  test('fromParsed true', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('true');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed, MiraiLiteral.bool(true));
    expect(parsed.isTrue, true);
    expect((parsed.asTypeLiteral as MiraiBoolean) == true, true);
    expect(parsed.value, true);
    expect(parsed.toString(), 'MiraiLiteral(MiraiBoolean(true))');
  });

  test('fromParsed false', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('false');
    expect(MiraiLiteral.fromParsed(result.value).isFalse, true);
  });

  test('fromParsed 0xFFFF', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('0xFFFF');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed.asInt, 0xFFFF);
    expect((parsed.asTypeLiteral as MiraiNumber) == 0xFFFF, true);
  });

  test('fromParsed 123456', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('123456');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed.asInt, 123456);
    expect(parsed.toString(), 'MiraiLiteral(MiraiNumber(123456))');
  });

  test('fromParsed 12.34', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('12.34');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed.asDouble, 12.34);
    expect(parsed.toString(), 'MiraiLiteral(MiraiNumber(12.34))');
  });

  test('fromParsed multi-line String', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('''
      """
      Hello
      world
      """
    ''');
    expect(MiraiLiteral.fromParsed(result.value).isString, true);
  });

  test('fromParsed "String"', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('"Hello"');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed.asString, 'Hello');
    expect((parsed.asTypeLiteral as MiraiString) == 'Hello', true);
    expect(parsed.toString(), 'MiraiLiteral(MiraiString(\"Hello\"))');
  });

  test('fromParsed .enumLiteral', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('.enumLiteral');
    final parsed = MiraiLiteral.fromParsed(result.value);

    expect(parsed.asEnumLiteral.toString(), 'enumLiteral');
    expect(
        (parsed.asTypeLiteral as MiraiEnumLiteral) ==
            MiraiQualified(['enumLiteral']),
        true);
    expect((parsed.asTypeLiteral as MiraiEnumLiteral) == 'enumLiteral', true);
    expect(parsed.toString(), 'MiraiLiteral(MiraiEnumLiteral(enumLiteral))');
  });

  test('fromParsed invalid', () {
    expect(() => MiraiLiteral.fromParsed(Token<dynamic>('abc', 'abc', 0, 3)),
        throwsA(isA<Exception>()));
    expect(
        () => MiraiLiteral.fromParsed(Token<Token<dynamic>>(
            Token<dynamic>('abc', 'abc', 0, 3), 'abc', 0, 3)),
        throwsA(isA<Exception>()));
    expect(
        () => MiraiLiteral.fromParsed(Token<List<dynamic>>([
              'a',
              Token<String>('b', 'b', 1, 2),
            ], 'ab', 0, 2)),
        throwsA(isA<Exception>()));
    expect(
        () => MiraiLiteral.fromParsed(Token<List<dynamic>>([
              Token<String>('a', 'a', 0, 1),
              Token<String>('b', 'b', 1, 2),
            ], '0xb', 0, 2)),
        throwsA(isA<Exception>()));
  });
}

void main() {
  testLiteral();
}
