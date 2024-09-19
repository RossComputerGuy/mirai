import 'package:petitparser/petitparser.dart';

class MiraiNullSafetyAnnotation {
  final bool isOptional;

  const MiraiNullSafetyAnnotation.optional() : isOptional = true;
  const MiraiNullSafetyAnnotation.not() : isOptional = false;

  bool get isNot => !isOptional;

  @override
  bool operator ==(Object other) {
    if (other is MiraiNullSafetyAnnotation) {
      return other.isOptional == isOptional && other.isNot == isNot;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiNullSafetyAnnotation(isOptional: ${isOptional ? 'true' : 'false'}, isNot: ${isNot ? 'true' : 'false'})';

  static MiraiNullSafetyAnnotation fromParsed(Token<dynamic> parsed) =>
      parsed.value == '?'
          ? MiraiNullSafetyAnnotation.optional()
          : MiraiNullSafetyAnnotation.not();
}
