import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:mirai/src/lang/mirai/types/import.dart';
import 'package:test/test.dart';

void testImport() {
  test('fromParsed generic', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c";');
    final parsed = MiraiImport.fromParsed(result.value);

    expect(parsed, MiraiImport('a/b/c'));
    expect(parsed.toString(), 'MiraiImport("a/b/c")');
  });

  test('fromParsed with as', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c" as d;');
    final parsed = MiraiImport.fromParsed(result.value);

    expect(parsed, MiraiImport('a/b/c', scope: 'd'));
    expect(parsed.toString(), 'MiraiImport("a/b/c", scope: "d")');
  });

  test('fromParsed with show', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c" show d;');
    final parsed = MiraiImport.fromParsed(result.value);

    expect(parsed, MiraiImport('a/b/c', visible: ['d']));
    expect(parsed.toString(), 'MiraiImport("a/b/c", visible: ["d"])');
  });

  test('fromParsed with hide', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c" hide d;');
    final parsed = MiraiImport.fromParsed(result.value);

    expect(parsed, MiraiImport('a/b/c', hidden: ['d']));
    expect(parsed.toString(), 'MiraiImport("a/b/c", hidden: ["d"])');
  });

  test('fromParsed with as, show', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c" as d show e;');
    expect(MiraiImport.fromParsed(result.value),
        MiraiImport('a/b/c', scope: 'd', visible: ['e']));
  });

  test('fromParsed with as, hide', () {
    final grammar = MiraiGrammarDefinition();
    final parser = grammar.buildFrom(grammar.importDirective());
    final result = parser.parse('import "a/b/c" as d hide e;');
    expect(MiraiImport.fromParsed(result.value),
        MiraiImport('a/b/c', scope: 'd', hidden: ['e']));
  });
}

void main() {
  testImport();
}
