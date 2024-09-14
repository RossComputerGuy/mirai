import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testLiteral() {
  test('fromParsed null', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('null');
    expect(MiraiLiteral.fromParsed(result.value).isNull, true);
  });

  test('fromParsed true', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('true');
    expect(MiraiLiteral.fromParsed(result.value).isTrue, true);
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
    expect(MiraiLiteral.fromParsed(result.value).asInt, 0xFFFF);
  });

  test('fromParsed 123456', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('123456');
    expect(MiraiLiteral.fromParsed(result.value).asInt, 123456);
  });

  test('fromParsed 12.34', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('12.34');
    expect(MiraiLiteral.fromParsed(result.value).asDouble, 12.34);
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
    expect(MiraiLiteral.fromParsed(result.value).asString, 'Hello');
  });

  test('fromParsed .enumLiteral', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.literal());
    final result = parser.parse('.enumLiteral');
    expect(MiraiLiteral.fromParsed(result.value).asEnumLiteral.toString(),
        'enumLiteral');
  });
}

void main() {
  testLiteral();
}
