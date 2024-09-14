import 'package:petitparser/petitparser.dart';

class MiraiTopLevelDefinition {
  final Object _value;

  const MiraiTopLevelDefinition._(this._value);

  @override
  String toString() => _value.toString();

  static MiraiTopLevelDefinition? fromParsed(List<dynamic> parsed) {
    return null;
  }
}
