import 'package:mirai/src/lang/mirai/types/expression.dart';
import 'package:mirai/src/lang/mirai/types/literal.dart';
import 'package:mirai/src/lang/mirai/types/primary.dart';
import 'package:mirai/src/lang/mirai/types/qualified.dart';
import 'package:mirai/src/lang/mirai/types/type.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testPrimary() {
  test('fromParsed variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('value');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(parsed, MiraiPrimary.identifier('value'));
  });

  test('fromParsed super', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('super');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(parsed, MiraiPrimary.assignableSuper());
  });

  test('fromParsed this', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('this');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(parsed, MiraiPrimary.assignableThis());
  });

  test('fromParsed literal', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('\"A\"');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(parsed, MiraiPrimary.literal(MiraiLiteral.string('A')));
  });

  test('fromParsed new class', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('new MyClass()');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.constructClass(MiraiConstructClass(
            MiraiType.qualified(MiraiQualified(['MyClass'])), [])));
  });

  test('fromParsed new class with name', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('new MyClass.abc()');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.constructClass(MiraiConstructClass(
            MiraiType.qualified(MiraiQualified(['MyClass', 'abc'])), [])));
  });

  test('fromParsed expression in parentheses', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('(value)');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(parsed, MiraiPrimary.wrappedExpression(MiraiExpression()));
  });

  test('fromParsed compound literal list', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('[ 1, 2, 3 ]');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(MiraiCompoundLiteral.list([
          MiraiExpression(isPointer: false),
          MiraiExpression(isPointer: false),
          MiraiExpression(isPointer: false)
        ])));
  });

  test('fromParsed compound literal list with type', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('<A>[ 1, 2, 3 ]');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.list([
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false)
            ]),
            types: [
              MiraiType.qualified(MiraiQualified(['A']))
            ]));
  });

  test('fromParsed constant compound literal list', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('const [ 1, 2, 3 ]');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.list([
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false)
            ]),
            isConst: true));
  });

  test('fromParsed constant compound literal list with type', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('const <A, B, C>[ 1, 2, 3 ]');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.list([
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false),
              MiraiExpression(isPointer: false)
            ]),
            isConst: true,
            types: [
              MiraiType.qualified(MiraiQualified(['A']))
            ]));
  });

  test('fromParsed compound literal map', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('{ "a": 1, "b": "2", "c": 3 }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(MiraiCompoundLiteral.map({
          'a': MiraiExpression(isPointer: false),
          'b': MiraiExpression(isPointer: false),
          'c': MiraiExpression(isPointer: false)
        })));
  });

  test('fromParsed constant compound literal map', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('const { "a": 1, "b": "2", "c": 3 }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.map({
              'a': MiraiExpression(isPointer: false),
              'b': MiraiExpression(isPointer: false),
              'c': MiraiExpression(isPointer: false)
            }),
            isConst: true));
  });

  test('fromParsed compound literal map with type', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('<A, B, C>{ "a": 1, "b": "2", "c": 3 }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.map({
              'a': MiraiExpression(isPointer: false),
              'b': MiraiExpression(isPointer: false),
              'c': MiraiExpression(isPointer: false)
            }),
            types: [
              MiraiType.qualified(MiraiQualified(['A']))
            ]));
  });

  test('fromParsed constant compound literal map with type', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('const <A, B, C>{ "a": 1, "b": "2", "c": 3 }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    expect(
        parsed,
        MiraiPrimary.compoundLiteral(
            MiraiCompoundLiteral.map({
              'a': MiraiExpression(isPointer: false),
              'b': MiraiExpression(isPointer: false),
              'c': MiraiExpression(isPointer: false)
            }),
            isConst: true,
            types: [
              MiraiType.qualified(MiraiQualified(['A']))
            ]));
  });

  test('fromParsed function expression block', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result =
        parser.parse('fn (a: String, b: String) String => { return a + b; }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });
  test('fromParsed function expression labeled block', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse(
        'fn combineString(a: String, b: String) String => { return a + b; }');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement no arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse('fn () String => "Hello, world"');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement optional argument', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse(
        'fn ([ prefix: String = "" ]) String => prefix + "Hello, world"');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement optional arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse(
        'fn ([ prefix: String = "", suffix: String = "" ]) String => prefix + "Hello, world" + suffix');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement named argument', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser
        .parse('fn ({ prefix: String }) String => prefix + "Hello, world"');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement named arguments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser.parse(
        'fn ({ prefix: String, other: Number, abc: Object }) String => prefix + "Hello, world"');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression statement', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result = parser
        .parse('fn (a: String, b: String, c: String) String => a + b + c');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });

  test('fromParsed function expression labeled statement', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.primary());
    final result =
        parser.parse('fn combineString(a: String, b: String) String => a + b');
    final parsed = MiraiPrimary.fromParsed(result.value);

    print(parsed);
  });
}

void main() {
  testPrimary();
}
