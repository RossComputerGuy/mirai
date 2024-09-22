import '../expression.dart';
import '../statement.dart';

class MiraiAsmStatement {
  final bool isVolatile;
  final String code;
  final Map<String, dynamic> params;

  const MiraiAsmStatement(
    this.code, {
    this.isVolatile = false,
    this.params = const {},
  });

  @override
  String toString() =>
      'MiraiAsmStatement(\"$code\", isVolatile: ${isVolatile ? 'true' : 'false'}, params: $params)';

  static MiraiAsmStatement fromParsed(List<dynamic> parsed) {
    if (parsed.length == 7) {
      return MiraiAsmStatement(
        parsed[3][1].join(),
        isVolatile: parsed[1] == null ? false : parsed[1].value == 'volatile',
        params: Map.fromEntries(parsed[4]
            .map((param) => MapEntry<String, dynamic>(
                param[1][0][1].join(), MiraiExpression.fromParsed(param[1][2])))
            .cast<MapEntry<String, dynamic>>()
            .toList()),
      );
    }

    throw Exception('Cannot parse: $parsed - ${parsed.length}');
  }
}
