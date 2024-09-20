import 'expression/assignable.dart';

class MiraiExpression {
  final bool isPointer;
  final MiraiAssignableExpression? assignable;

  const MiraiExpression({
    this.isPointer = false,
    this.assignable = null,
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiExpression) {
      return other.isPointer == isPointer && other.assignable == assignable;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiExpression(isPointer: ${isPointer ? 'true' : 'false'}, assignable: $assignable)';

  static MiraiExpression fromParsed(List<dynamic> parsed) {
    if (parsed.length == 2) {
      return MiraiExpression(
        isPointer: parsed[0] == null ? false : parsed[0].value == '&',
        assignable: parsed[1][0] != null
            ? MiraiAssignableExpression.fromParsed(
                parsed[1][0][0][0][0][0][0][0][0][0][0][0])
            : null,
      );
    }

    throw Exception('Cannot parse: $parsed');
  }
}
