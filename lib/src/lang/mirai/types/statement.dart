import 'package:petitparser/petitparser.dart';
import 'statement/block.dart';
import 'statement/break.dart';
import 'statement/continue.dart';
import 'statement/defer.dart';
import 'statement/unreachable.dart';

class MiraiStatement {
  final List<String> labels;
  final Object value;

  const MiraiStatement(
    this.value, {
    this.labels = const [],
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiStatement) {
      if (other.labels.length == labels.length) {
        var i = 0;
        while (i < labels.length) {
          if (other.labels[i] != labels[i]) return false;
          i++;
        }
      }
      return true;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiStatement($value, labels: [${labels.map((label) => '\"$label\"').join(', ')}])';

  static Object valueFromParsed(List<dynamic> parsed) {
    if (parsed.length == 3) {
      if (parsed[0] is Token<dynamic> && parsed[2] is Token<dynamic>) {
        if (parsed[0].value == '{' && parsed[2].value == '}') {
          return MiraiBlockStatement.fromParsed(parsed);
        }
      }

      if (parsed[0] is Token<dynamic>) {
        switch (parsed[0].value) {
          case 'break':
            return MiraiBreakStatement.fromParsed(parsed);
          case 'continue':
            return MiraiContinueStatement.fromParsed(parsed);
          case 'defer':
          case 'errdefer':
            return MiraiDeferStatement.fromParsed(parsed);
        }
      }
    }

    if (parsed.length == 2) {
      if (parsed[0] is Token<dynamic>) {
        switch (parsed[0].value) {
          case 'unreachable':
            return MiraiUnreachableStatement();
        }
      }
    }

    throw Exception('Failed to parse: $parsed');
  }

  static MiraiStatement fromParsedValue(List<dynamic> parsed) =>
      MiraiStatement(valueFromParsed(parsed));

  static MiraiStatement fromParsed(List<dynamic> parsed) {
    List<String> labels = [];

    if (parsed[0] is List<dynamic>) {
      if (parsed[0].length > 0) {
        labels = parsed[0]
            .map((label) => label[0].value[0] + label[0].value[1].join())
            .cast<String>()
            .toList();
      }
    }

    return MiraiStatement(
      valueFromParsed(parsed[1]),
      labels: labels,
    );
  }
}
