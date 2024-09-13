import 'cpu.dart';
import 'os.dart';

class MiraiTargetAbi {
  final String name;

  const MiraiTargetAbi(this.name);

  @override
  bool operator ==(Object other) {
    if (other is MiraiTargetAbi) {
      return name == other.name;
    }
    return false;
  }

  @override
  String toString() => name;

  static MiraiTargetAbi defaultFor(MiraiCpuArch arch, MiraiTargetOs os) {
    if (arch.isWasm) {
      return musl;
    }

    return switch (os) {
      MiraiTargetOs.freestanding => eabi,
      MiraiTargetOs.linux => musl,
      _ => none,
    };
  }

  static MiraiTargetAbi? fromString(String input) {
    try {
      return values.firstWhere((el) => el.name == input);
    } on StateError catch (_) {
      return null;
    }
  }

  static const none = MiraiTargetAbi('none');
  static const eabi = MiraiTargetAbi('eabi');
  static const gnu = MiraiTargetAbi('gnu');
  static const gnueabi = MiraiTargetAbi('gnueabi');
  static const musl = MiraiTargetAbi('musl');

  static List<MiraiTargetAbi> values = [
    none,
    eabi,
    gnu,
    gnueabi,
    musl,
  ];
}
