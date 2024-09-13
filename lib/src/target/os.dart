class MiraiTargetOs {
  final String name;

  const MiraiTargetOs(this.name);

  @override
  bool operator ==(Object other) {
    if (other is MiraiTargetOs) {
      return name == other.name;
    }
    return false;
  }

  @override
  String toString() => name;

  static MiraiTargetOs? fromString(String input) {
    try {
      return values.firstWhere((el) => el.name == input);
    } on StateError catch (_) {
      return null;
    }
  }

  static const freestanding = MiraiTargetOs('freestanding');
  static const linux = MiraiTargetOs('linux');

  static List<MiraiTargetOs> values = [
    freestanding,
    linux,
  ];
}
