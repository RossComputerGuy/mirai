import 'package:petitparser/petitparser.dart';
import 'expression.dart';
import 'null_safety.dart';

class MiraiAssignableSelector {
  final Object accessor;
  final MiraiNullSafetyAnnotation? nullSafety;

  const MiraiAssignableSelector.key(
    MiraiExpression value, {
    this.nullSafety = null,
  }) : accessor = value;

  const MiraiAssignableSelector.identifier(
    String value, {
    this.nullSafety = null,
  }) : accessor = value;

  @override
  bool operator ==(Object other) {
    if (other is MiraiAssignableSelector) {
      return other.accessor == accessor && other.nullSafety == nullSafety;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiAssignableSelector($accessor, nullSafety: $nullSafety)';

  static MiraiAssignableSelector fromParsed(List<dynamic> parsed) {
    if (parsed.length == 2) {
      final nullSafety = parsed[1] != null
          ? MiraiNullSafetyAnnotation.fromParsed(parsed[1])
          : null;

      if (parsed[0][0].value == '[') {
        return MiraiAssignableSelector.key(
            MiraiExpression.fromParsed(parsed[0][1]),
            nullSafety: nullSafety);
      }

      if (parsed[0][0].value == '.') {
        return MiraiAssignableSelector.identifier(
            parsed[0][1].value[0] + parsed[0][1].value[1].join(),
            nullSafety: nullSafety);
      }
    }

    if (parsed.length == 3) {
      if (parsed[0].value == '[') {
        return MiraiAssignableSelector.key(
            MiraiExpression.fromParsed(parsed[1]));
      }
    }

    throw Exception('Cannot parse: $parsed - ${parsed.length}');
  }
}
