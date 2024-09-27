import 'package:petitparser/petitparser.dart';
import 'expression/assignable.dart';
import 'operator.dart';

class MiraiExpression {
  final MiraiAssignableExpression? assignable;
  final MiraiAssignmentOperator? assignOperator;
  final MiraiExpression? innerExpression;

  const MiraiExpression({
    this.assignable = null,
    this.assignOperator = null,
    this.innerExpression = null,
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiExpression) {
      return other.assignable == assignable &&
          other.assignOperator == assignOperator &&
          other.innerExpression == innerExpression;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiExpression(assignable: $assignable, assignOperator: $assignOperator, innerExpression: $innerExpression)';

  static MiraiExpression fromParsed(List<dynamic> parsed) => MiraiExpression(
        assignable: parsed[0] != null
            ? MiraiAssignableExpression.fromParsed(parsed[0][0])
            : (parsed[1] != null && !(parsed[1] is Token<dynamic>)
                ? MiraiAssignableExpression.fromParsed(parsed[1][0])
                : null),
        assignOperator: parsed[1] != null && parsed[1][0] is Token<dynamic>
            ? MiraiAssignmentOperator.fromParsed(parsed[1][0])
            : null,
        innerExpression: parsed[1] != null && parsed[1][0] is Token<dynamic>
            ? fromParsed(parsed[1][1])
            : null,
      );
}
