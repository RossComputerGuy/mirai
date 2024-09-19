import 'package:mirai/src/lang/mirai/types/expression/assignable.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testAssignableExpression() {
  test('fromParsed variable', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('value');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression());
  });

  test('fromParsed variable item', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('value[1]');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression());
  });

  test('fromParsed function call', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('myFunction(1, 2, 3)');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression());
  });

  test('fromParsed call list item', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('myFunction[1](2, 3, 4)');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression());
  });

  test('fromParsed super list', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.assignableExpression());
    final result = parser.parse('super[0]');
    final parsed = MiraiAssignableExpression.fromParsed(result.value);

    expect(parsed, MiraiAssignableExpression());
  });
}

void main() {
  testAssignableExpression();
}
