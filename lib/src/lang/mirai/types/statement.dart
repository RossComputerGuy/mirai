import 'package:petitparser/petitparser.dart';

class MiraiStatement {
  final List<String> labels;

  const MiraiStatement({
    this.labels = const [],
  });

  @override
  bool operator==(Object other) {
    if (other is MiraiStatement) {
      if (other.labels.length == labels.length) {
        var i = 0;
        while (i < labels.length) {
          if (other.labels[i] != labels[i]) return false;
          i++;
        }
      }
      return true;
    }
    return false;
  }

  @override
  String toString() => 'MiraiStatement(labels: [${labels.map((label) => '\"$label\"').join(', ')}])';

  static MiraiStatement fromParsed(List<dynamic> parsed) {
    List<String> labels = [];

    if (parsed[0] is List<dynamic>) {
      if (parsed[0].length > 0) {
        labels = parsed[0].map((label) => label[0].value[0] + label[0].value[1].join()).cast<String>().toList();
      }
    }

    return MiraiStatement(
      labels: labels,
    );
  }
}
