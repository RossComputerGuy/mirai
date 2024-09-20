import 'package:mirai/src/lang/mirai/types/statement/asm.dart';
import 'package:mirai/src/lang/mirai/types/statement/block.dart';
import 'package:mirai/src/lang/mirai/types/statement/continue.dart';
import 'package:mirai/src/lang/mirai/types/statement/defer.dart';
import 'package:mirai/src/lang/mirai/types/statement/unreachable.dart';
import 'package:mirai/src/lang/mirai/types/statement.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testStatement() {
  test('fromParsed label', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('label: { break label; }');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiBlockStatement(), labels: ['label']));
    expect(parsed.toString(),
        'MiraiStatement(MiraiBlockStatement([MiraiStatement(MiraiBreakStatement(\"label\"), labels: [])]), labels: [\"label\"])');
  });

  test('fromParsed defer', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('defer {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(
            MiraiDeferStatement(MiraiStatement(MiraiBlockStatement()))));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: false, isPre: false), labels: [])');
  });

  test('fromParsed defer preret', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('defer preret {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(MiraiDeferStatement(
            MiraiStatement(MiraiBlockStatement()),
            isPre: true)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: false, isPre: true), labels: [])');
  });

  test('fromParsed defer postret', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('defer postret {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(MiraiDeferStatement(
            MiraiStatement(MiraiBlockStatement()),
            isPre: false)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: false, isPre: false), labels: [])');
  });

  test('fromParsed errdefer', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('errdefer {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(MiraiDeferStatement(
            MiraiStatement(MiraiBlockStatement()),
            isError: true)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: true, isPre: false), labels: [])');
  });

  test('fromParsed errdefer postret', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('errdefer postret {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(MiraiDeferStatement(
            MiraiStatement(MiraiBlockStatement()),
            isError: true,
            isPre: false)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: true, isPre: false), labels: [])');
  });

  test('fromParsed errdefer preret', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('errdefer preret {}');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(
        parsed,
        MiraiStatement(MiraiDeferStatement(
            MiraiStatement(MiraiBlockStatement()),
            isError: true,
            isPre: true)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiDeferStatement(MiraiStatement(MiraiBlockStatement([]), labels: []), isError: true, isPre: true), labels: [])');
  });

  test('fromParsed continue', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('continue;');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiContinueStatement()));

    expect(parsed.toString(),
        'MiraiStatement(MiraiContinueStatement(), labels: [])');
  });

  test('fromParsed continue labeled', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('continue label;');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiContinueStatement('label')));

    expect(parsed.toString(),
        'MiraiStatement(MiraiContinueStatement(\"label\"), labels: [])');
  });

  test('fromParsed unreachable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('unreachable;');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiUnreachableStatement()));

    expect(parsed.toString(),
        'MiraiStatement(MiraiUnreachableStatement(), labels: [])');
  });

  test('fromParsed asm', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('asm ("hlt");');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiAsmStatement('hlt')));

    expect(parsed.toString(),
        'MiraiStatement(MiraiAsmStatement(\"hlt\", isVolatile: false, params: {}), labels: [])');
  });

  test('fromParsed asm volatile', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('asm volatile ("hlt");');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiAsmStatement('hlt', isVolatile: true)));

    expect(parsed.toString(),
        'MiraiStatement(MiraiAsmStatement(\"hlt\", isVolatile: true, params: {}), labels: [])');
  });

  test('fromParsed asm with parameters', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('asm ("hlt", "a": 1, "b": true, "c": value);');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(MiraiAsmStatement('hlt')));

    expect(parsed.toString(),
        'MiraiStatement(MiraiAsmStatement("hlt", isVolatile: false, params: {a: MiraiExpression(isPointer: false, assignable: MiraiAssignableExpression(MiraiPrimary(literal: MiraiLiteral(MiraiNumber(1))), [])), b: MiraiExpression(isPointer: false, assignable: MiraiAssignableExpression(MiraiPrimary(literal: MiraiLiteral(MiraiBoolean(true))), [])), c: MiraiExpression(isPointer: false, assignable: MiraiAssignableExpression(MiraiPrimary(identifier: value), []))}), labels: [])');
  });

  test('fromParsed invalid', () {
    expect(() => MiraiStatement.valueFromParsed([]), throwsA(isA<Exception>()));
  });
}

void main() {
  testStatement();
}
