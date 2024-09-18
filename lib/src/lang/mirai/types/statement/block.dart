import '../statement.dart';

class MiraiBlockStatement {
  final List<MiraiStatement> statements;

  const MiraiBlockStatement([this.statements = const []]);

  @override
  String toString() => 'MiraiBlockStatement($statements)';

  static MiraiBlockStatement fromParsed(List<dynamic> parsed) =>
      MiraiBlockStatement(parsed[1]
          .map((parsed) => MiraiStatement.fromParsed(parsed))
          .cast<MiraiStatement>()
          .toList());
}
