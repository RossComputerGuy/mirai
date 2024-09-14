import 'package:petitparser/petitparser.dart';

class MiraiQualified {
  final List<String> parts;

  const MiraiQualified(this.parts);

  @override
  String toString() => parts.join('.');

  @override
  bool operator ==(Object other) {
    if (other is MiraiQualified) {
      return toString() == other.toString();
    }
    return false;
  }

  static MiraiQualified fromParsed(List<dynamic> parsed) {
    if (parsed.length > 0) {
      if (parsed[0] is Token<dynamic>) {
        return MiraiQualified(parsed
            .expand((item) {
              if (item is Token) {
                return [item.value[0] + item.value[1].join()];
              }
              return item
                  .map((i) => i[1].value[0] + i[1].value[1].join())
                  .toList();
            })
            .toList()
            .cast());
      }
    }
    return MiraiQualified([parsed[0] + parsed[1].join()]);
  }
}
