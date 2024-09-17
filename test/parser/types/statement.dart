import 'package:mirai/src/lang/mirai/types/statement.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testStatement() {
  test('fromParsed label', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.statement());
    final result = parser.parse('label: { break label; }');
    final parsed = MiraiStatement.fromParsed(result.value);

    expect(parsed, MiraiStatement(labels: ['label']));
    expect(parsed.toString(), 'MiraiStatement(labels: [\"label\"])');
  });
}

void main() {
  testStatement();
}
