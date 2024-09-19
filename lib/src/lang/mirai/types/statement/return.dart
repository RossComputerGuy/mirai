import '../expression.dart';

class MiraiReturnStatement {
  final MiraiExpression value;

  const MiraiReturnStatement(this.value);

  @override
  bool operator ==(Object other) {
    if (other is MiraiReturnStatement) {
      return other.value == value;
    }
    return false;
  }

  @override
  String toString() => 'MiraiReturnStatement($value)';

  static MiraiReturnStatement fromParsed(List<dynamic> parsed) =>
      MiraiReturnStatement(MiraiExpression.fromParsed(parsed[1]));
}
