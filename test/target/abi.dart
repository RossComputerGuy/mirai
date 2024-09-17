import 'package:mirai/src/target/abi.dart';
import 'package:test/test.dart';

void testAbi() {
  test('fromString', () {
    expect(MiraiTargetAbi.fromString('abc'), null);

    for (final value in MiraiTargetAbi.values) {
      expect(MiraiTargetAbi.fromString(value.name)!, value);
      expect(MiraiTargetAbi.fromString(value.name)!.toString(), value.name);
    }
  });
}

void main() {
  testAbi();
}
