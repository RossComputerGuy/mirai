import 'package:petitparser/petitparser.dart';
import 'qualified.dart';

abstract class MiraiTypeLiteral<T> {
  final T value;

  const MiraiTypeLiteral(this.value);
}

class MiraiBoolean extends MiraiTypeLiteral<bool> {
  const MiraiBoolean(bool value) : super(value);

  @override
  bool operator ==(Object other) {
    if (other is MiraiBoolean) {
      return other.value == value;
    }

    if (other is bool) {
      return other == value;
    }
    return false;
  }

  @override
  String toString() => 'MiraiBoolean(${value ? 'true' : 'false'})';

  static const trueValue = MiraiBoolean(true);
  static const falseValue = MiraiBoolean(false);
}

class MiraiNumber extends MiraiTypeLiteral<num> {
  const MiraiNumber(num value) : super(value);
  const MiraiNumber.int(int _value) : super(_value);
  const MiraiNumber.double(double _value) : super(_value);

  int get asInt => value as int;
  double get asDouble => value as double;

  @override
  bool operator ==(Object other) {
    if (other is MiraiNumber) {
      return other.value == value;
    }

    if (other is int) {
      return other == value;
    }
    return false;
  }

  @override
  String toString() => 'MiraiNumber(${value.toString()})';
}

class MiraiEnumLiteral extends MiraiTypeLiteral<MiraiQualified> {
  const MiraiEnumLiteral(MiraiQualified value) : super(value);

  @override
  bool operator ==(Object other) {
    if (other is MiraiEnumLiteral) {
      return other.value == value;
    }

    if (other is MiraiQualified) {
      return other == value;
    }

    if (other is String) {
      return other == value.toString();
    }
    return false;
  }

  @override
  String toString() => 'MiraiEnumLiteral($value)';
}

class MiraiString extends MiraiTypeLiteral<String> {
  const MiraiString(String value) : super(value);

  @override
  bool operator ==(Object other) {
    if (other is MiraiString) {
      return other.value == value;
    }

    if (other is String) {
      return other == value;
    }
    return false;
  }

  @override
  String toString() => 'MiraiString(\"$value\")';
}

class MiraiLiteral {
  final Object? _value;

  const MiraiLiteral(this._value);
  factory MiraiLiteral.bool(bool value) => MiraiLiteral(MiraiBoolean(value));
  factory MiraiLiteral.enumLiteral(MiraiQualified value) =>
      MiraiLiteral(MiraiEnumLiteral(value));
  factory MiraiLiteral.int(int value) => MiraiLiteral(MiraiNumber.int(value));
  factory MiraiLiteral.double(double value) =>
      MiraiLiteral(MiraiNumber.double(value));
  factory MiraiLiteral.num(num value) => MiraiLiteral(MiraiNumber(value));
  factory MiraiLiteral.string(String value) => MiraiLiteral(MiraiString(value));

  bool get isNull => _value == null;
  bool get isTrue => _value is MiraiBoolean && _value.value;
  bool get isFalse => _value is MiraiBoolean && !_value.value;
  bool get isNumber => _value is MiraiNumber;
  bool get isEnumLiteral => _value is MiraiEnumLiteral;
  bool get isString => _value is MiraiString;

  bool get isInt => isNumber && (_value as MiraiNumber).value is int;
  bool get isDouble => isNumber && (_value as MiraiNumber).value is double;

  int get asInt {
    assert(isInt);
    return (_value as MiraiNumber).asInt;
  }

  double get asDouble {
    assert(isDouble);
    return (_value as MiraiNumber).asDouble;
  }

  String get asString {
    assert(isString);
    return (_value as MiraiString).value;
  }

  MiraiQualified get asEnumLiteral {
    assert(isEnumLiteral);
    return (_value as MiraiEnumLiteral).value;
  }

  MiraiTypeLiteral? get asTypeLiteral {
    if (isNull) return null;
    return (_value as MiraiTypeLiteral<dynamic>);
  }

  dynamic get value {
    if (isNull) return null;
    return (_value as MiraiTypeLiteral<dynamic>).value;
  }

  @override
  bool operator ==(Object other) {
    if (other is MiraiLiteral) {
      return other._value == _value;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiLiteral(${_value == null ? 'null' : _value.toString()})';

  static MiraiLiteral fromParsed(Token<dynamic> parsed) {
    if (parsed.value is Token<dynamic>) {
      return switch (parsed.value.value) {
        'null' => MiraiLiteral(null),
        'true' => MiraiLiteral(MiraiBoolean.trueValue),
        'false' => MiraiLiteral(MiraiBoolean.falseValue),
        _ => throw Exception('Cannot parse literal: ${parsed.value.value}'),
      };
    }

    if (parsed.value is List<dynamic>) {
      if (parsed.value.length == 2) {
        if (parsed.value[0] is String) {
          if (parsed.value[0].toLowerCase() != '0x') {
            throw Exception('Cannot parse hex: ${parsed.value[0]}');
          }
          return MiraiLiteral(MiraiNumber(
              int.parse('0x' + parsed.value[1].join('').toLowerCase())));
        }
        if (parsed.value[0] is Token<dynamic>) {
          if (parsed.value[0].value != '.') {
            throw Exception(
                'Cannot parse enum literal: ${parsed.value[0].value}');
          }

          return MiraiLiteral(MiraiEnumLiteral(
              MiraiQualified.fromParsed(parsed.value[1].value)));
        }
      }

      if (parsed.value.length == 4) {
        final value = parsed.value.where((x) => x != null).toList();
        if (value.length == 2) {
          return MiraiLiteral(MiraiNumber(
              double.parse(value[0].join() + '.' + value[1][1].join())));
        } else if (value.length == 1) {
          return MiraiLiteral(MiraiNumber(int.parse(value[0].join())));
        }
      }

      if (parsed.value.length == 3) {
        return MiraiLiteral(MiraiString(parsed.value[1].join()));
      }

      if (parsed.value.length == 2) {
        return MiraiLiteral(MiraiString(parsed.value[1][1].join('')));
      }
    }
    throw Exception('Cannot parse: $parsed');
  }
}
