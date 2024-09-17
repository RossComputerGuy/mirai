import 'package:mirai/src/target.dart';
import 'package:test/test.dart';

import 'target/abi.dart' hide main;
import 'target/cpu.dart' hide main;
import 'target/ofmt.dart' hide main;
import 'target/os.dart' hide main;

void testTarget() {
  group('ABI', testAbi);
  group('CPU', testCpu);
  group('Object Format', testOfmt);
  group('OS', testOs);

  test('Parse target double', () {
    final target = MiraiTarget.fromString('aarch64-linux');
    expect(
        target,
        MiraiTarget.double(
          arch: MiraiCpuArch.aarch64,
          os: MiraiTargetOs.linux,
        ));
    expect(target.toString(), 'aarch64-linux-musl');
  });

  test('Parse target triple', () {
    final target = MiraiTarget.fromString('aarch64-linux-gnueabi');
    expect(
        target,
        MiraiTarget.triple(
          arch: MiraiCpuArch.aarch64,
          os: MiraiTargetOs.linux,
          abi: MiraiTargetAbi.gnueabi,
        ));
    expect(target.toString(), 'aarch64-linux-gnueabi');
    expect(target.copyWith(abi: MiraiTargetAbi.none).toString(),
        'aarch64-linux-none');
    expect(target.copyWith(ofmt: MiraiObjectFormat.c).toString(),
        target.toString());
  });

  test('Parse target invalid', () {
    expect(() => MiraiTarget.fromString('aarch64-linux-gnieabi'),
        throwsA(isA<Exception>()));
    expect(() => MiraiTarget.fromString('aarch64-linus-gnueabi'),
        throwsA(isA<Exception>()));
    expect(() => MiraiTarget.fromString('aarch-linux-gnueabi'),
        throwsA(isA<Exception>()));
  });
}

void main() {
  testTarget();
}
