import 'target/cpu.dart';
export 'target/cpu.dart';

import 'target/os.dart';
export 'target/os.dart';

import 'target/abi.dart';
export 'target/abi.dart';

import 'target/ofmt.dart';
export 'target/ofmt.dart';

class MiraiTarget {
  final MiraiCpuArch arch;
  final MiraiTargetOs os;
  final MiraiTargetAbi abi;
  final MiraiObjectFormat ofmt;

  const MiraiTarget({
    required this.arch,
    required this.os,
    required this.abi,
    required this.ofmt,
  });

  factory MiraiTarget.double({
    required MiraiCpuArch arch,
    required MiraiTargetOs os,
  }) =>
      MiraiTarget.triple(
        arch: arch,
        os: os,
        abi: MiraiTargetAbi.defaultFor(arch, os),
      );

  factory MiraiTarget.triple({
    required MiraiCpuArch arch,
    required MiraiTargetOs os,
    required MiraiTargetAbi abi,
  }) =>
      MiraiTarget(
        arch: arch,
        os: os,
        abi: abi,
        ofmt: MiraiObjectFormat.defaultFor(arch, os),
      );

  MiraiTarget copyWith({
    MiraiCpuArch? arch,
    MiraiTargetOs? os,
    MiraiTargetAbi? abi,
    MiraiObjectFormat? ofmt,
  }) =>
      MiraiTarget(
        arch: arch ?? this.arch,
        os: os ?? this.os,
        abi: abi ?? this.abi,
        ofmt: ofmt ?? this.ofmt,
      );

  @override
  bool operator ==(Object other) {
    if (other is MiraiTarget) {
      return arch == other.arch &&
          os == other.os &&
          abi == other.abi &&
          ofmt == other.ofmt;
    }
    return false;
  }

  @override
  String toString() => '${arch.name}-${os.name}-${abi.name}';

  static MiraiTarget fromString(String input) {
    final parts = input.split('-');
    assert(parts.length > 1 && parts.length < 4);

    final arch = MiraiCpuArch.fromString(parts[0]) ??
        (throw Exception('Unrecognized arch: ${parts[0]}'));
    final os = MiraiTargetOs.fromString(parts[1]) ??
        (throw Exception('Unrecognized OS: ${parts[0]}'));
    var abi = MiraiTargetAbi.defaultFor(arch, os);

    if (parts.length > 2) {
      abi = MiraiTargetAbi.fromString(parts[2]) ??
          (throw Exception('Unrecognized ABI: ${parts[0]}'));
    }

    return MiraiTarget.triple(
      arch: arch,
      os: os,
      abi: abi,
    );
  }
}
