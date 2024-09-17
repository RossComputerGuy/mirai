import 'package:mirai/src/target/ofmt.dart';
import 'package:test/test.dart';

void testOfmt() {
  test('fromString', () {
    expect(MiraiObjectFormat.fromString('abc'), null);

    for (final value in MiraiObjectFormat.values) {
      expect(MiraiObjectFormat.fromString(value.name)!, value);
      expect(MiraiObjectFormat.fromString(value.name)!.toString(), value.name);
    }
  });
}

void main() {
  testOfmt();
}
