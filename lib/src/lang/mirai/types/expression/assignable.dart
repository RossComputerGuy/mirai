import 'package:petitparser/petitparser.dart';
import '../expression.dart';
import '../primary.dart';
import '../selector.dart';

class MiraiArgument {
  final String? label;
  final MiraiExpression value;

  const MiraiArgument(this.value, this.label);

  static MiraiArgument fromParsed(List<dynamic> parsed) => MiraiArgument(
      MiraiExpression.fromParsed(parsed[1]),
      parsed[0] != null
          ? parsed[0][0].value[0] + parsed[0][0].value[1].join()
          : null);
}

class MiraiAssignableExpression {
  final MiraiPrimary? base;
  final List<Object> arguments;

  const MiraiAssignableExpression(this.base, [this.arguments = const []]);

  @override
  bool operator ==(Object other) {
    if (other is MiraiAssignableExpression) {
      return other.base == base;
    }
    return false;
  }

  @override
  String toString() => 'MiraiAssignableExpression($base, $arguments)';

  static MiraiAssignableExpression fromParsed(List<dynamic> parsed) =>
      MiraiAssignableExpression(
          parsed[0] != null ? MiraiPrimary.fromParsed(parsed[0]) : null,
          parsed[1]
              .map((parsed) {
                if (parsed.length == 2)
                  return MiraiAssignableSelector.fromParsed(parsed);
                if (parsed.length == 5)
                  return parsed[1]
                      .elements
                      .map((parsed) => MiraiArgument.fromParsed(parsed))
                      .cast<MiraiArgument>()
                      .toList();
                throw Exception('Cannot parse: $parsed');
              })
              .cast<Object>()
              .toList());
}
