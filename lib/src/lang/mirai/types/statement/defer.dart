import '../statement.dart';

class MiraiDeferStatement {
  final bool isError;
  final bool isPre;
  final MiraiStatement statement;

  const MiraiDeferStatement(
    this.statement, {
    this.isError = false,
    this.isPre = false,
  });

  @override
  String toString() =>
      'MiraiDeferStatement($statement, isError: ${isError ? 'true' : 'false'}, isPre: ${isPre ? 'true' : 'false'})';

  static MiraiDeferStatement fromParsed(List<dynamic> parsed) =>
      MiraiDeferStatement(MiraiStatement.fromParsedValue(parsed[2]),
          isPre: parsed[1] == null ? false : parsed[1].value == 'preret',
          isError: parsed[0].value == 'errdefer');
}
