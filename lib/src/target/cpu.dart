class MiraiCpuArch {
  final String name;

  const MiraiCpuArch(this.name);

  bool get isWasm => this == wasm32 || this == wasm64;

  @override
  bool operator ==(Object other) {
    if (other is MiraiCpuArch) {
      return name == other.name;
    }
    return false;
  }

  @override
  String toString() => name;

  static MiraiCpuArch? fromString(String input) {
    try {
      return values.firstWhere((el) => el.name == input);
    } on StateError catch (_) {
      return null;
    }
  }

  static const aarch64 = MiraiCpuArch('aarch64');
  static const wasm32 = MiraiCpuArch('wasm32');
  static const wasm64 = MiraiCpuArch('wasm64');

  static List<MiraiCpuArch> values = [
    aarch64,
    wasm32,
    wasm64,
  ];
}
