import 'package:mirai/src/target/cpu.dart';
import 'package:test/test.dart';

void testCpu() {
  test('fromString', () {
    expect(MiraiCpuArch.fromString('abc'), null);

    for (final value in MiraiCpuArch.values) {
      expect(MiraiCpuArch.fromString(value.name)!, value);
      expect(MiraiCpuArch.fromString(value.name)!.toString(), value.name);
    }
  });
}

void main() {
  testCpu();
}
