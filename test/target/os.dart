import 'package:mirai/src/target/os.dart';
import 'package:test/test.dart';

void testOs() {
  test('fromString', () {
    expect(MiraiTargetOs.fromString('abc'), null);

    for (final value in MiraiTargetOs.values) {
      expect(MiraiTargetOs.fromString(value.name)!, value);
      expect(MiraiTargetOs.fromString(value.name)!.toString(), value.name);
    }
  });
}

void main() {
  testOs();
}
