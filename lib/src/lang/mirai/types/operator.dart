import 'package:petitparser/petitparser.dart';

enum MiraiAssignmentOperator {
  assign,
  multiply,
  divide,
  roundMultiply,
  mod,
  add,
  sub,
  lshift,
  rshift,
  urshift,
  and,
  or,
  xor;

  static MiraiAssignmentOperator fromParsed(Token<dynamic> parsed) =>
      switch (parsed.value) {
        '=' => MiraiAssignmentOperator.assign,
        '*=' => MiraiAssignmentOperator.multiply,
        '/=' => MiraiAssignmentOperator.divide,
        '~/=' => MiraiAssignmentOperator.roundMultiply,
        '%=' => MiraiAssignmentOperator.mod,
        (_) => throw Exception('Cannot parse: $parsed'),
      };
}
