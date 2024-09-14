import 'dart:io';

import 'package:mirai/src/lang/mirai/grammar.dart';
import 'package:mirai/src/lang/mirai/types.dart';
import 'package:mirai/mirai.dart';
import 'package:petitparser/petitparser.dart';

void printHelp() {
  stdout.writeAll([
    'Mirai Compiler\n',
    'Usage: mirai [command] [options]\n\n',
    'Commands:\n\n',
    '\tparse\tParses the input and outputs in codegen form\n',
    '\thelp\tPrints this output\n',
  ]);
}

Future<void> parse(List<String> args) async {
  String? source_file;

  int i = 0;
  String arg;
  while (args.length > 0) {
    arg = args.removeAt(0);

    if (arg == '--help') {
      stdout.writeAll([
        'Usage: mirai parse [file] [options]\n\n',
        'Parses the file provided and dumps the codegen.\n\n',
        'Options:\n\n',
        '\t--help\tPrints this output\n',
      ]);
      return;
    } else if (i == 0) {
      source_file = arg;
    } else {
      stderr.writeAll(['error: Unexpected argument "${arg}"\n']);
      return;
    }

    i++;
  }

  if (source_file == null) {
    stderr.writeAll(['error: No path to a file was provided\n']);
    return;
  }

  final source = await File(source_file!).readAsString();

  final parser = MiraiGrammarDefinition().build();
  switch (parser.parse(source)) {
    case Success(value: final value):
      print(value[1]
          .map((parsed) => MiraiTopLevelDefinition.fromParsed(parsed))
          .toList());
      break;
    case Failure(position: final position, message: final message):
      stderr.writeln('${Token.positionString(source, position)} - $message');
      exit(1);
  }
}

Future<void> main(List<String> args) async {
  if (args.length == 0) {
    printHelp();
    return;
  }

  switch (args[0]) {
    case 'help':
    case '--help':
      printHelp();
      break;
    case 'parse':
      await parse(args.sublist(1));
      break;
    default:
      stderr.writeAll(['error: Unknown command ${args[0]}\n']);
      break;
  }
}
