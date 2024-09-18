import '../statement.dart';

class MiraiContinueStatement {
  final String? identifier;

  const MiraiContinueStatement([this.identifier = null]);

  @override
  String toString() =>
      'MiraiContinueStatement(${identifier != null ? '\"$identifier\"' : ''})';

  static MiraiContinueStatement fromParsed(List<dynamic> parsed) {
    if (parsed[1] == null) return MiraiContinueStatement();

    return MiraiContinueStatement(
        parsed[1].value[0] + parsed[1].value[1].join());
  }
}
