import 'expression/assignable.dart';

class MiraiExpression {
  final bool isPointer;

  const MiraiExpression({
    this.isPointer = false,
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiExpression) {
      return other.isPointer == isPointer;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiExpression(isPointer: ${isPointer ? 'true' : 'false'})';

  static MiraiExpression fromParsed(List<dynamic> parsed) {
    //print(MiraiAssignableExpression.fromParsed(parsed[1]));
    return MiraiExpression(
      isPointer: parsed[0] == null ? false : parsed[0].value == '&',
    );
  }
}
