class MiraiImport {
  final String name;
  final String? scope;
  final List<String> visible;
  final List<String> hidden;

  const MiraiImport(
    this.name, {
    this.scope,
    this.visible = const [],
    this.hidden = const [],
  });

  @override
  bool operator ==(Object other) {
    if (other is MiraiImport) {
      if (other.visible.length == visible.length) {
        var i = 0;
        while (i < visible.length) {
          if (other.visible[i] != visible[i]) return false;
          i++;
        }
      }

      if (other.hidden.length == hidden.length) {
        var i = 0;
        while (i < hidden.length) {
          if (other.hidden[i] != hidden[i]) return false;
          i++;
        }
      }

      return name == other.name && scope == other.scope;
    }
    return false;
  }

  @override
  String toString() {
    final opts = [
      scope != null ? 'scope: \"$scope\"' : null,
      visible.length > 0
          ? 'visible: [${visible.map((x) => '\"$x\"').join(', ')}]'
          : null,
      hidden.length > 0
          ? 'hidden: [${hidden.map((x) => '\"$x\"').join(', ')}]'
          : null,
    ].where((x) => x != null);
    return 'MiraiImport(\"${name}\"${opts.length > 0 ? ', ' : ''}${opts.join(', ')})';
  }

  static MiraiImport fromParsed(List<dynamic> parsed) {
    final opts = parsed.sublist(2, parsed.length - 1);
    String? scope = null;
    if (opts[0] != null) {
      scope =
          opts[0][1].value.map((i) => i is List<dynamic> ? i.join() : i).join();
    }

    List<String> visible = [];
    List<String> hidden = [];

    if (opts[1] != null) {
      final value = opts[1][1]
          .elements
          .map((e) =>
              e.value.map((i) => i is List<dynamic> ? i.join() : i).join())
          .toList()
          .cast<String>();
      switch (opts[1][0].value) {
        case 'show':
          visible = value;
          break;
        case 'hide':
          hidden = value;
          break;
      }
    }
    return MiraiImport(parsed[1][1].join(),
        scope: scope, visible: visible, hidden: hidden);
  }
}
