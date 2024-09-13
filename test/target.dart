import 'package:mirai/src/target.dart';
import 'package:test/test.dart';

void testTarget() {
  test('Parse target double', () {
    expect(
        MiraiTarget.fromString('aarch64-linux'),
        MiraiTarget.double(
          arch: MiraiCpuArch.aarch64,
          os: MiraiTargetOs.linux,
        ));
  });

  test('Parse target triple', () {
    expect(
        MiraiTarget.fromString('aarch64-linux-gnueabi'),
        MiraiTarget.triple(
          arch: MiraiCpuArch.aarch64,
          os: MiraiTargetOs.linux,
          abi: MiraiTargetAbi.gnueabi,
        ));
  });
}

void main() {
  testTarget();
}
