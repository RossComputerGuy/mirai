import 'package:petitparser/petitparser.dart';
import 'literal.dart';
import 'qualified.dart';

class MiraiType {
  final Object type;
  final List<MiraiType> arguments;

  const MiraiType._(this.type, [this.arguments = const []]);
  factory MiraiType.literal(MiraiLiteral literal,
          [List<MiraiType> arguments = const []]) =>
      MiraiType._(literal, arguments);
  factory MiraiType.qualified(MiraiQualified qualified,
          [List<MiraiType> arguments = const []]) =>
      MiraiType._(qualified, arguments);

  bool get isTypeLiteral => type is MiraiLiteral;
  bool get isTypeQualified => type is MiraiQualified;

  MiraiLiteral get asLiteral => type as MiraiLiteral;
  MiraiQualified get asQualified => type as MiraiQualified;

  @override
  bool operator ==(Object other) {
    if (other is MiraiType) {
      if (other.arguments.length == arguments.length) {
        var i = 0;
        while (i < arguments.length) {
          if (other.arguments[i] != arguments[i]) return false;
          i++;
        }
      } else {
        return false;
      }
      return other.type == type;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiType($type${arguments.length > 0 ? ', [${arguments.join(', ')}]' : ''})';

  static MiraiType fromParsed(List<dynamic> parsed) {
    List<MiraiType> args = [];
    if (parsed[1] != null) {
      args.add(MiraiType.fromParsed(parsed[1][1][0]));
      args.addAll(parsed[1][1][1]
          .map((x) => MiraiType.fromParsed(x.sublist(1)[0]))
          .cast<MiraiType>()
          .toList());
    }

    if (parsed[0] is Token) {
      return MiraiType._(MiraiLiteral.fromParsed(parsed[0]), args);
    }

    return MiraiType._(MiraiQualified.fromParsed(parsed[0]), args);
  }
}
