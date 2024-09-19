class MiraiExpression {
  final bool isPointer;

  const MiraiExpression({
    this.isPointer = false,
  });

  @override
  String toString() =>
      'MiraiExpression(isPointer: ${isPointer ? 'true' : 'false'})';

  static MiraiExpression fromParsed(List<dynamic> parsed) {
    print(parsed[1]);
    return MiraiExpression(
      isPointer: parsed[0] == null ? false : parsed[0].value == '&',
    );
  }
}
