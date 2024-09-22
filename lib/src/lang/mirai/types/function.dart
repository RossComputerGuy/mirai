import 'annotation.dart';
import 'expression.dart';
import 'type.dart';

class MiraiFormalParameter {
  final List<MiraiAnnotation> annotations;
  final bool isFinal;
  final String name;
  final MiraiType? type;
  final MiraiExpression? defaultValue;

  const MiraiFormalParameter(
    this.name,
    this.type, {
    this.isFinal = false,
    this.annotations = const [],
    this.defaultValue = null,
  });

  @override
  String toString() =>
      'MiraiFormalParameter(\"$name\", $type, annotations: $annotations, isFinal: ${isFinal ? 'true' : 'false'}, defaultValue: $defaultValue)';

  static MiraiFormalParameter fromParsed(List<dynamic> parsed) =>
      MiraiFormalParameter(parsed[0][2].value[0] + parsed[0][2].value[1].join(),
          parsed[0][3] != null ? MiraiType.fromParsed(parsed[0][3][1]) : null,
          isFinal: parsed[0][1] != null ? parsed[0][1].value == 'final' : false,
          annotations: parsed[0][0] != null
              ? parsed[0][0]
                  .map((parsed) => MiraiAnnotation.fromParsed(parsed))
                  .cast<MiraiAnnotation>()
                  .toList()
              : null,
          defaultValue: parsed[1] != null
              ? MiraiExpression.fromParsed(parsed[1][1])
              : null);

  static List<MiraiFormalParameter> fromParsedList(List<dynamic> parsed) {
    if (parsed.length == 3) {
      if (parsed[1] is List<dynamic>) {
        List<MiraiFormalParameter> value = [];
        value.add(MiraiFormalParameter.fromParsed(parsed[1][1]));
        value.addAll(parsed[1][2]
            .map((parsed) => MiraiFormalParameter.fromParsed(parsed[1]))
            .cast<MiraiFormalParameter>()
            .toList());
        return value;
      }

      if (parsed[1] == null) return [];
    }

    if (parsed.length == 4) {
      List<MiraiFormalParameter> value = [];
      value.add(MiraiFormalParameter.fromParsed([parsed[1], null]));
      // TODO: add more parameters
      return value;
    }

    throw Exception('Cannot parse: $parsed - ${parsed.length}');
  }
}
