import '../statement.dart';

class MiraiBreakStatement {
  final String? identifier;

  const MiraiBreakStatement([this.identifier = null]);

  @override
  String toString() =>
      'MiraiBreakStatement(${identifier != null ? '\"$identifier\"' : ''})';

  static MiraiBreakStatement fromParsed(List<dynamic> parsed) {
    if (parsed[1] == null) return MiraiBreakStatement();

    return MiraiBreakStatement(parsed[1].value[0] + parsed[1].value[1].join());
  }
}
