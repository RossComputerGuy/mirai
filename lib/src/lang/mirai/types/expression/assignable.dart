import 'package:petitparser/petitparser.dart';

class MiraiAssignableExpression {
  const MiraiAssignableExpression();

  @override
  bool operator ==(Object other) {
    if (other is MiraiAssignableExpression) {
      return true;
    }
    return false;
  }

  @override
  String toString() => 'MiraiAssignableExpression()';

  static MiraiAssignableExpression fromParsed(List<dynamic> parsed) {
    print(parsed);
    return MiraiAssignableExpression();
  }
}
