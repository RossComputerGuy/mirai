import 'cpu.dart';
import 'os.dart';

class MiraiObjectFormat {
  final String name;

  const MiraiObjectFormat(this.name);

  @override
  bool operator ==(Object other) {
    if (other is MiraiObjectFormat) {
      return name == other.name;
    }
    return false;
  }

  @override
  String toString() => name;

  static MiraiObjectFormat defaultFor(MiraiCpuArch arch, MiraiTargetOs os) {
    return switch (arch) {
      MiraiCpuArch.wasm32 => wasm,
      MiraiCpuArch.wasm64 => wasm,
      _ => elf,
    };
  }

  static MiraiObjectFormat? fromString(String input) {
    try {
      return values.firstWhere((el) => el.name == input);
    } on StateError catch (_) {
      return null;
    }
  }

  static const c = MiraiObjectFormat('c');
  static const elf = MiraiObjectFormat('elf');
  static const wasm = MiraiObjectFormat('wasm');

  static List<MiraiObjectFormat> values = [
    c,
    elf,
    wasm,
  ];
}
