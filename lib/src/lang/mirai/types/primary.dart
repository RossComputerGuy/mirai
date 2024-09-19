import 'package:petitparser/petitparser.dart';
import 'statement/block.dart';
import 'expression.dart';
import 'function.dart';
import 'literal.dart';
import 'selector.dart';
import 'type.dart';

class MiraiConstructClass {
  final bool isConst;
  final MiraiType type;
  final List<MiraiExpression> arguments;

  const MiraiConstructClass(
    this.type,
    this.arguments, {
    this.isConst = false,
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiConstructClass) {
      if (arguments.length == other.arguments.length) {
        var i = 0;
        while (i < arguments.length) {
          if (other.arguments[i] != arguments[i]) return false;
          i++;
        }
      }
      return other.isConst == isConst && other.type == type;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiConstructClass($type, $arguments, isConst: ${isConst ? 'true' : 'false'}';
}

class MiraiFunctionExpression {
  final String? name;
  final List<MiraiFormalParameter> params;
  final MiraiType? returnType;
  final Object body;

  const MiraiFunctionExpression(
    this.name,
    this.params,
    MiraiExpression value, {
    this.returnType = null,
  }) : body = value;

  const MiraiFunctionExpression.block(
    this.name,
    this.params,
    MiraiBlockStatement value, {
    this.returnType = null,
  }) : body = value;

  @override
  bool operator ==(Object other) {
    if (other is MiraiFunctionExpression) {
      if (other.params.length == params.length) {
        var i = 0;
        while (i < params.length) {
          if (other.params[i] != params[i]) return false;
          i++;
        }
      } else {
        return false;
      }

      return other.name == name &&
          other.returnType == returnType &&
          other.body == body;
    }
    return false;
  }

  @override
  String toString() =>
      'MiraiFunctionExpression($name, $params, $body, returnType: $returnType)';
}

class MiraiPrimary {
  final MiraiLiteral? literal;
  final String? identifier;
  final MiraiConstructClass? constructClass;
  final bool isSuper;
  final bool isThis;
  final bool isConst;
  final MiraiAssignableSelector? selector;
  final MiraiExpression? wrappedExpression;
  final MiraiCompoundLiteral? compoundLiteral;
  final List<MiraiType> types;
  final MiraiFunctionExpression? functionExpression;

  const MiraiPrimary.literal(MiraiLiteral value)
      : literal = value,
        identifier = null,
        constructClass = null,
        isSuper = false,
        isThis = false,
        isConst = false,
        selector = null,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.identifier(String value)
      : literal = null,
        identifier = value,
        constructClass = null,
        isSuper = false,
        isThis = false,
        isConst = false,
        selector = null,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.assignableSuper([this.selector = null])
      : literal = null,
        identifier = null,
        constructClass = null,
        isSuper = true,
        isThis = false,
        isConst = false,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.assignableThis([this.selector = null])
      : literal = null,
        identifier = null,
        constructClass = null,
        isSuper = false,
        isThis = true,
        isConst = false,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.constructClass(MiraiConstructClass value)
      : literal = null,
        identifier = null,
        constructClass = value,
        isSuper = false,
        isThis = false,
        isConst = false,
        selector = null,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.wrappedExpression(MiraiExpression value)
      : literal = null,
        identifier = null,
        constructClass = null,
        isSuper = false,
        isThis = false,
        isConst = false,
        selector = null,
        wrappedExpression = value,
        compoundLiteral = null,
        types = const [],
        functionExpression = null;
  const MiraiPrimary.compoundLiteral(
    MiraiCompoundLiteral value, {
    this.isConst = false,
    this.types = const [],
  })  : literal = null,
        identifier = null,
        constructClass = null,
        isSuper = false,
        isThis = false,
        selector = null,
        wrappedExpression = null,
        compoundLiteral = value,
        functionExpression = null;
  const MiraiPrimary.functionExpression(MiraiFunctionExpression value)
      : literal = null,
        identifier = null,
        constructClass = null,
        isSuper = false,
        isThis = false,
        isConst = false,
        selector = null,
        wrappedExpression = null,
        compoundLiteral = null,
        types = const [],
        functionExpression = value;

  @override
  bool operator ==(Object other) {
    if (other is MiraiPrimary) {
      if (other.types.length == types.length) {
        var i = 0;
        while (i < types.length) {
          if (other.types[i] != types[i]) return false;
          i++;
        }
      } else {
        return false;
      }

      return other.literal == literal &&
          other.identifier == identifier &&
          other.constructClass == constructClass &&
          other.isSuper == isSuper &&
          other.isThis == isThis &&
          other.isConst == isConst &&
          other.wrappedExpression == wrappedExpression &&
          other.compoundLiteral == compoundLiteral &&
          other.functionExpression == functionExpression;
    }
    return false;
  }

  @override
  String toString() {
    if (isThis) return 'MiraiPrimary(isThis: true, $selector)';
    if (isSuper) return 'MiraiPrimary(isSuper: true, $selector)';
    if (identifier != null) return 'MiraiPrimary(identifier: $identifier)';
    if (literal != null) return 'MiraiPrimary(literal: $literal)';
    if (constructClass != null)
      return 'MiraiPrimary(constructClass: $constructClass)';
    if (wrappedExpression != null)
      return 'MiraiPrimary(wrappedExpression: $wrappedExpression)';
    if (compoundLiteral != null)
      return 'MiraiPrimary(compoundLiteral: $compoundLiteral, isConst: ${isConst ? 'true' : 'false'}, types: $types)';
    if (functionExpression != null)
      return 'MiraiPrimary(functionExpression: $functionExpression)';
    return 'MiraiPrimary()';
  }

  static MiraiPrimary fromParsed(dynamic parsed) {
    if (parsed is Token<dynamic>) {
      if (parsed.value is List<dynamic>) {
        if (parsed.value.length == 2) {
          if (parsed.value[0].toLowerCase() != '0x') {
            return MiraiPrimary.identifier(
                parsed.value[0] + parsed.value[1].join());
          }
        }
      }

      return MiraiPrimary.literal(MiraiLiteral.fromParsed(parsed));
    }

    if (parsed is List<dynamic>) {
      if (parsed.length == 5) {
        if (parsed[0] is Token<dynamic>) {
          if (parsed[0].value == 'fn') {
            final name = parsed[1] != null
                ? parsed[1].value[0] + parsed[1].value[1].join()
                : null;
            final returnType =
                parsed[3] != null ? MiraiType.fromParsed(parsed[3]) : null;

            final params = MiraiFormalParameter.fromParsedList(parsed[2]);

            if (parsed[4][1][0] is Token<dynamic>) {
              if (parsed[4][1][0].value == '{') {
                return MiraiPrimary.functionExpression(
                    MiraiFunctionExpression.block(name, params,
                        MiraiBlockStatement.fromParsed(parsed[4][1]),
                        returnType: returnType));
              }
            }

            return MiraiPrimary.functionExpression(MiraiFunctionExpression(
                name, params, MiraiExpression.fromParsed(parsed[4][1]),
                returnType: returnType));
          }
        }
      }

      if (parsed.length == 3) {
        if (parsed[0] is Token<dynamic>) {
          if (parsed[0].value == '(') {
            return MiraiPrimary.wrappedExpression(
                MiraiExpression.fromParsed(parsed[1]));
          }
        }

        if (parsed[2] is List<dynamic>) {
          if (parsed[2][0].value != '(') {
            List<MiraiType> types = [];
            if (parsed[1] != null) {
              types.add(MiraiType.fromParsed(parsed[1][1][0]));
            }

            return MiraiPrimary.compoundLiteral(
                MiraiCompoundLiteral.fromParsed(parsed[2]),
                isConst: parsed[0] != null ? parsed[0].value == 'const' : false,
                types: types);
          }
        }

        return MiraiPrimary.constructClass(MiraiConstructClass(
          MiraiType.fromParsed(parsed[1]),
          parsed[2][1] != null
              ? parsed[2][1]
                  .elements
                  .map((parsed) => MiraiExpression.fromParsed(parsed))
                  .cast<MiraiExpression>()
                  .toList()
              : [],
          isConst: parsed[0] == null ? false : parsed[0].value == 'const',
        ));
      }

      if (parsed.length == 2) {
        final selector = parsed[1] != null
            ? MiraiAssignableSelector.fromParsed(parsed[1])
            : null;

        if (parsed[0].value == 'super') {
          return MiraiPrimary.assignableSuper(selector);
        }

        if (parsed[0].value == 'this') {
          return MiraiPrimary.assignableThis(selector);
        }
      }
    }

    throw Exception('Cannot parse: $parsed');
  }
}
