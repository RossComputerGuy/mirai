import 'package:mirai/src/lang/mirai/types/qualified.dart';
import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:test/test.dart';

void testQualified() {
  test('fromParsed 1 segment', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.qualified());
    final result = parser.parse('a');
    expect(
        MiraiQualified.fromParsed(result.value),
        MiraiQualified([
          'a',
        ]));
  });

  test('fromParsed 3 segments', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.qualified());
    final result = parser.parse('a.bb.ccc');
    expect(
        MiraiQualified.fromParsed(result.value),
        MiraiQualified([
          'a',
          'bb',
          'ccc',
        ]));
  });
}

void main() {
  testQualified();
}
