import 'package:petitparser/petitparser.dart';

class MiraiGrammarDefinition extends GrammarDefinition {
  Parser token(Object input) {
    if (input is Parser) {
      return input.token().trim(ref0(hiddenStuffWhitespace));
    } else if (input is String) {
      return token(input.toParser());
    }
    throw ArgumentError.value(input, 'Invalid token parser');
  }

  Parser namespaceToken() => ref1(token, 'namespace');
  Parser asmToken() => ref1(token, 'asm');
  Parser volatileToken() => ref1(token, 'volatile');
  Parser tryToken() => ref1(token, 'try');
  Parser finallyToken() => ref1(token, 'finally');
  Parser catchToken() => ref1(token, 'catch');
  Parser enumToken() => ref1(token, 'enum');
  Parser structToken() => ref1(token, 'struct');
  Parser interfaceToken() => ref1(token, 'interface');
  Parser operatorToken() => ref1(token, 'operator');
  Parser staticToken() => ref1(token, 'static');
  Parser abstractToken() => ref1(token, 'abstract');
  Parser classToken() => ref1(token, 'class');
  Parser typedefToken() => ref1(token, 'typedef');
  Parser whileToken() => ref1(token, 'while');
  Parser doToken() => ref1(token, 'do');
  Parser forToken() => ref1(token, 'for');
  Parser defaultToken() => ref1(token, 'default');
  Parser ifToken() => ref1(token, 'if');
  Parser elseToken() => ref1(token, 'else');
  Parser switchToken() => ref1(token, 'switch');
  Parser caseToken() => ref1(token, 'case');
  Parser assertToken() => ref1(token, 'assert');
  Parser returnToken() => ref1(token, 'return');
  Parser continueToken() => ref1(token, 'continue');
  Parser throwsToken() => ref1(token, 'throws');
  Parser throwToken() => ref1(token, 'throw');
  Parser breakToken() => ref1(token, 'break');
  Parser constToken() => ref1(token, 'const');
  Parser newToken() => ref1(token, 'new');
  Parser nullToken() => ref1(token, 'null');
  Parser trueToken() => ref1(token, 'true');
  Parser falseToken() => ref1(token, 'false');
  Parser thisToken() => ref1(token, 'this');
  Parser superToken() => ref1(token, 'super');
  Parser exportToken() => ref1(token, 'export');
  Parser pubToken() => ref1(token, 'pub');
  Parser fnToken() => ref1(token, 'fn');
  Parser finalToken() => ref1(token, 'final');
  Parser varToken() => ref1(token, 'var');
  Parser voidToken() => ref1(token, 'void');
  Parser unreachableToken() => ref1(token, 'unreachable');
  Parser factoryToken() => ref1(token, 'factory');
  Parser negateToken() => ref1(token, 'negate');

  Parser errdeferToken() => ref1(token, 'errdefer');
  Parser deferToken() => ref1(token, 'defer');
  Parser preretToken() => ref1(token, 'preret');
  Parser postretToken() => ref1(token, 'postret');
  Parser implementsToken() => ref1(token, 'implements');
  Parser extendsToken() => ref1(token, 'extends');
  Parser externToken() => ref1(token, 'extern');
  Parser getToken() => ref1(token, 'get');
  Parser setToken() => ref1(token, 'set');
  Parser asToken() => ref1(token, 'as');
  Parser isToken() => ref1(token, 'is');
  Parser inToken() => ref1(token, 'in');
  Parser importToken() => ref1(token, 'import');
  Parser hideToken() => ref1(token, 'hide');
  Parser showToken() => ref1(token, 'show');

  @override
  Parser start() => ref0(compilationUnit).end();

  Parser compilationUnit() =>
      ref0(importDirective).star() & ref0(topLevelDefinition).star();

  Parser importDirective() =>
      ref0(importToken) &
      ref0(singleLineStringLexicalToken) &
      (ref0(asToken) & ref0(identifier)).optional() &
      ((ref0(showToken) | ref0(hideToken)) &
              ref0(identifier).plusSeparated(ref1(token, ',')))
          .optional() &
      ref1(token, ';');

  Parser namespaceDefinition() =>
      ref0(pubToken).optional() &
      ref0(namespaceToken) &
      ref0(identifier) &
      ref1(token, '{') &
      ref0(topLevelDefinition).star() &
      ref1(token, '}');

  Parser topLevelDefinition() =>
      ref0(enumDefinition) |
      ref0(structDefinition) |
      ref0(classDefinition) |
      ref0(interfaceDefinition) |
      ref0(functionExternDefinition) |
      ref0(functionTypeAlias) |
      ref0(typeAlias) |
      ref0(functionDeclaration) & ref0(functionBodyOrExtern) |
      ref0(getOrSet) &
          ref0(identifier) &
          ref0(returnType).optional() &
          ref0(formalParameterList) &
          ref0(functionBodyOrExtern) |
      ref0(finalToken) &
          ref0(staticFinalDeclarationList) &
          ref0(typeIdentifier).optional() &
          ref0(throwsIdentifier).optional() &
          ref1(token, ';') |
      ref0(constToken) &
          ref0(staticFinalDeclarationList) &
          ref0(typeIdentifier).optional() &
          ref0(throwsIdentifier).optional() &
          ref1(token, ';') |
      ref0(constInitializedVariableDeclaration) & ref1(token, ';') |
      ref0(namespaceDefinition);

  Parser annotationDirective() =>
      ref1(token, '@') & ref0(identifier) & ref0(arguments);

  Parser classDefinition() =>
      ref0(annotationDirective).star() &
      ref0(abstractToken).optional() &
      ref0(pubToken).optional() &
      ref0(classToken) &
      ref0(identifier) &
      ref0(typeParameters).optional() &
      ref0(superclass).optional() &
      ref0(interfaces).optional() &
      ref1(token, '{') &
      ref0(classMemberDefinition).star() &
      ref1(token, '}');

  Parser interfaceDefinition() =>
      ref0(annotationDirective).star() &
      ref0(pubToken).optional() &
      ref0(interfaceToken) &
      ref0(identifier) &
      ref0(typeParameters).optional() &
      ref0(superclass).optional() &
      ref0(interfaces).optional() &
      ref1(token, '{') &
      ref0(classMemberDefinition).star() &
      ref1(token, '}');

  Parser enumDefinition() =>
      ref0(annotationDirective).star() &
      ref0(pubToken).optional() &
      ref0(enumToken) &
      ref0(identifier) &
      ref0(superclass).optional() &
      ref0(typeParameters).optional() &
      ref1(token, '{') &
      ref0(enumMemberDefinition).star() &
      ref1(token, '}');

  Parser structDefinition() =>
      ref0(annotationDirective).star() &
      ref0(pubToken).optional() &
      ref0(structToken) &
      ref0(identifier) &
      ref0(typeParameters).optional() &
      ref1(token, '{') &
      ref0(classMemberDefinition).star() &
      ref1(token, '}');

  Parser functionDeclaration() =>
      ref0(annotationDirective).star() &
          ref0(exportToken).optional() &
          ref0(pubToken).optional() &
          ref0(fnToken) &
          ref0(identifier) &
          ref0(formalParameterList) &
          ref0(returnType) &
          ref0(throwsIdentifier).optional() |
      ref0(identifier) &
          ref0(formalParameterList) &
          ref0(throwsIdentifier).optional();

  Parser formalParameterList() =>
      ref1(token, '(') &
          ref0(optionalFormalParameters).optional() &
          ref1(token, ')') |
      ref1(token, '(') &
          ref0(namedFormalParameters).optional() &
          ref1(token, ')') |
      ref1(token, '(') &
          ref0(normalFormalParameter) &
          ref0(normalFormalParameterTail).optional() &
          ref1(token, ')');

  Parser normalFormalParameterTail() =>
      ref1(token, ',') & ref0(optionalFormalParameters) |
      ref1(token, ',') & ref0(namedFormalParameters) |
      ref1(token, ',') &
          ref0(normalFormalParameter) &
          ref0(normalFormalParameterTail).optional();

  Parser normalFormalParameter() =>
      ref0(fieldFormalParameter) |
      ref0(functionDeclaration) |
      ref0(declaredIdentifier);

  Parser fieldFormalParameter() =>
      ref0(thisToken) & ref1(token, '.') & ref0(identifier);

  Parser optionalFormalParameters() =>
      ref1(token, '[') &
      ref0(defaultFormalParameter) &
      (ref1(token, ',') & ref0(defaultFormalParameter)).star() &
      ref1(token, ']');

  Parser namedFormalParameters() =>
      ref1(token, '{') &
      ref0(namedFormatParameter) &
      (ref1(token, ',') & ref0(namedFormatParameter)).star() &
      ref1(token, '}');

  Parser namedFormatParameter() =>
      ref0(normalFormalParameter) &
      (ref1(token, ':') & ref0(constantExpression)).optional();

  Parser defaultFormalParameter() =>
      ref0(normalFormalParameter) &
      (ref1(token, '=') & ref0(constantExpression)).optional();

  Parser returnType() => ref0(voidToken) | ref0(type);

  Parser functionBodyOrExtern() =>
      ref0(externToken) & ref0(functionBody) |
      ref0(functionExtern) |
      ref0(functionBody);

  Parser functionExtern() =>
      ref0(externToken) &
      ref1(token, ref0(stringLexicalToken)).optional() &
      ref1(token, ';');

  Parser methodDeclaration() =>
      ref0(factoryConstructorDeclaration) |
      ref0(staticToken) & ref0(functionDeclaration) |
      ref0(specialSignatureDefinition) |
      ref0(functionDeclaration) & ref0(initializers).optional() |
      ref0(namedConstructorDeclaration) & ref0(initializers).optional();

  Parser staticDeclaration() =>
      ref0(staticToken) &
      (ref0(finalToken) | ref0(constToken) | ref0(varToken)) &
      ref0(staticFinalDeclarationList);

  Parser declaration() =>
      ref0(functionDeclaration) & ref0(redirection) |
      ref0(namedConstructorDeclaration) & ref0(redirection) |
      ref0(abstractToken) &
          (ref0(specialSignatureDefinition) | ref0(functionDeclaration)) |
      ref0(staticDeclaration) |
      ref0(staticToken).optional() & ref0(constInitializedVariableDeclaration);

  Parser initializers() =>
      ref1(token, ':') &
      ref0(superCallOrFieldInitializer) &
      (ref1(token, ',') & ref0(superCallOrFieldInitializer)).star();

  Parser redirection() =>
      ref1(token, ':') &
      ref0(thisToken) &
      (ref1(token, '.') & ref0(identifier)).optional() &
      ref0(arguments);

  Parser fieldInitializer() =>
      (ref0(thisToken) & ref1(token, '.')).optional() &
      ref0(identifier) &
      ref1(token, '=') &
      ref0(conditionalExpression);

  Parser superCallOrFieldInitializer() =>
      ref0(superToken) & ref0(arguments) |
      ref0(superToken) & ref1(token, '.') & ref0(identifier) & ref0(arguments) |
      ref0(fieldInitializer);

  Parser typeParameter() =>
      ref0(identifier) & (ref0(extendsToken) & ref0(type)).optional();

  Parser typeParameters() =>
      ref1(token, '<') &
      ref0(typeParameter) &
      (ref1(token, ',') & ref0(typeParameter)).star() &
      ref1(token, '>');

  Parser superclass() => ref0(extendsToken) & ref0(type);
  Parser interfaces() => ref0(implementsToken) & ref0(typeList);

  Parser classMemberDefinition() =>
      ref0(annotationDirective).star() &
      (ref0(declaration) & ref1(token, ';') |
          ref0(constructorDeclaration) & ref1(token, ';') |
          ref0(methodDeclaration) & ref0(functionBodyOrExtern) |
          ref0(constToken) &
              ref0(factoryConstructorDeclaration) &
              ref0(functionExtern));

  Parser enumMemberDefinition() =>
      ref0(annotationDirective).star() &
      ((ref0(identifier) & ref1(token, ',')) |
          (ref0(staticDeclaration) & ref1(token, ';')) |
          ref0(constructorDeclaration) & ref1(token, ';') |
          ref0(methodDeclaration) & ref0(functionBodyOrExtern) |
          ref0(constToken) &
              ref0(factoryConstructorDeclaration) &
              ref0(functionExtern));

  Parser factoryConstructorDeclaration() =>
      ref0(annotationDirective).star() &
      (ref0(factoryToken) &
          ref0(qualified) &
          ref0(typeParameters).optional() &
          (ref1(token, '.') & ref0(identifier)).optional() &
          ref0(formalParameterList));

  Parser constructorDeclaration() =>
      ref0(annotationDirective).star() &
      (ref0(constToken).optional() &
              ref0(identifier) &
              ref0(formalParameterList) &
              (ref0(redirection) | ref0(initializers)).optional() |
          ref0(constToken).optional() &
              ref0(namedConstructorDeclaration) &
              (ref0(redirection) | ref0(initializers)).optional());

  Parser namedConstructorDeclaration() =>
      ref0(identifier) &
      ref1(token, '.') &
      ref0(identifier) &
      ref0(formalParameterList);

  Parser specialSignatureDefinition() =>
      ref0(annotationDirective).star() &
      (ref0(staticToken).optional() &
              ref0(getOrSet) &
              ref0(identifier) &
              ref0(returnType).optional() &
              ref0(formalParameterList) |
          ref0(operatorToken) &
              ref0(userDefinableOperator) &
              ref0(formalParameterList) &
              ref0(returnType).optional());

  Parser userDefinableOperator() =>
      ref0(multiplicativeOperator) |
      ref0(additiveOperator) |
      ref0(shiftOperator) |
      ref0(relationalOperator) |
      ref0(bitwiseOperator) |
      ref1(token, '==') // Disallow negative and === equality checks.
      |
      ref1(token, '~') // Disallow ! operator.
      |
      ref0(negateToken) |
      ref1(token, '[') & ref1(token, ']') |
      ref1(token, '[') & ref1(token, ']') & ref1(token, '=');

  Parser arguments() =>
      ref1(token, '(') &
      ref0(argumentList).optional() &
      ref1(token, ',').optional() &
      ref1(token, ')') &
      nullSafetyAnnotations().optional();

  Parser argumentList() =>
      ref0(argumentElement).plusSeparated(ref1(token, ','));

  Parser argumentElement() => ref0(label).optional() & ref0(expression);

  Parser label() => ref0(identifier) & ref1(token, ':');

  Parser iterationStatement() =>
      ref0(whileToken) &
          ref1(token, '(') &
          ref0(expression) &
          ref1(token, ')') &
          ref0(statement) |
      ref0(doToken) &
          ref0(statement) &
          ref0(whileToken) &
          ref1(token, '(') &
          ref0(expression) &
          ref1(token, ')') &
          ref1(token, ';') |
      ref0(forToken) &
          ref1(token, '(') &
          ref0(forLoopParts) &
          ref1(token, ')') &
          ref0(statement);

  Parser forLoopParts() =>
      ref0(forInitializerStatement) &
          ref0(expression).optional() &
          ref1(token, ';') &
          ref0(expressionList).optional() |
      ref0(declaredIdentifier) & ref0(inToken) & ref0(expression) |
      ref0(identifier) & ref0(inToken) & ref0(expression);

  Parser forInitializerStatement() =>
      ref0(initializedVariableDeclaration) & ref1(token, ';') |
      ref0(expression).optional() & ref1(token, ';');

  Parser deferStatement() =>
      (ref0(deferToken) | ref0(errdeferToken)) &
      (ref0(postretToken) | ref0(preretToken)).optional() &
      (ref0(deferBlock) | ref0(deferBlockStatement));

  Parser deferBlock() =>
      ref1(token, '{') & ref0(deferBlockStatements) & ref1(token, '}');

  Parser deferBlockStatements() => (ref0(deferBlockStatement) |
          (ref0(initializedVariableDeclaration) & ref1(token, ';')))
      .star();

  Parser deferBlockStatement() =>
      ref0(nonLabelledGenericStatement) | ref0(expression) & ref1(token, ';');

  Parser nonLabelledStatement() =>
      ref0(block) |
      ref0(deferStatement) |
      ref0(iterationStatement) |
      ref0(selectionStatement) |
      ref0(tryStatement) |
      ref0(nonLabelledGenericStatement) |
      ref0(breakToken) & ref0(identifier).optional() & ref1(token, ';') |
      ref0(continueToken) & ref0(identifier).optional() & ref1(token, ';') |
      ref0(returnToken) & ref0(expression).optional() & ref1(token, ';') |
      ref0(initializedVariableDeclaration) & ref1(token, ';') |
      ref0(expression).optional() & ref1(token, ';') |
      ref0(functionDeclaration) & ref0(functionBody);

  Parser nonLabelledGenericStatement() =>
      ref0(iterationStatement) |
      ref0(selectionStatement) |
      ref0(asmStatement) |
      ref0(unreachableToken) & ref1(token, ';') |
      ref0(throwToken) & ref0(expression).optional() & ref1(token, ';') |
      ref0(assertToken) &
          ref1(token, '(') &
          ref0(conditionalExpression) &
          ref1(token, ')') &
          ref1(token, ';');

  Parser declaredIdentifier() =>
      ref0(annotationDirective).star() &
      (ref0(finalToken) | ref0(varToken)).optional() &
      ref0(identifier) &
      ref0(typeIdentifier).optional();

  Parser typeIdentifier() => ref1(token, ':') & ref0(type);

  Parser throwsIdentifier() =>
      (ref0(throwsToken) & ref0(identifier).plusSeparated(ref1(token, ',')))
          .star();

  Parser identifier() => ref1(token, ref0(identifierLexicalToken));

  Parser qualified() =>
      ref0(identifier) & (ref1(token, '.') & ref0(identifier)).star();

  Parser type() =>
      (ref0(literal) | ref0(qualified)) & ref0(typeArguments).optional();

  Parser typeArguments() =>
      ref1(token, '<') & ref0(typeList) & ref1(token, '>');

  Parser typeList() => ref0(type) & (ref1(token, ',') & ref0(type)).star();

  Parser block() => ref1(token, '{') & ref0(statements) & ref1(token, '}');

  Parser statements() => ref0(statement).star();

  Parser statement() => ref0(label).star() & ref0(nonLabelledStatement);

  Parser initializedVariableDeclaration() =>
      ref0(declaredIdentifier) &
      (ref1(token, '=') & ref0(expression)).optional() &
      (ref1(token, ',') & ref0(initializedIdentifier)).star();

  Parser initializedIdentifier() =>
      ref0(identifier) & (ref1(token, '=') & ref0(expression)).optional();

  Parser constInitializedVariableDeclaration() =>
      ref0(declaredIdentifier) &
      (ref1(token, '=') & ref0(constantExpression)).optional() &
      (ref1(token, ',') & ref0(constInitializedIdentifier)).star();

  Parser constInitializedIdentifier() =>
      ref0(identifier) &
      (ref1(token, '=') & ref0(constantExpression)).optional();

  Parser staticFinalDeclarationList() =>
      ref0(staticFinalDeclaration) &
      (ref1(token, ',') & ref0(staticFinalDeclaration)).star();

  Parser staticFinalDeclaration() =>
      ref0(identifier) &
      ref0(typeIdentifier).optional() &
      ref1(token, '=') &
      ref0(constantExpression);

  Parser functionExternDefinition() =>
      ref0(externToken) &
      ref0(pubToken).optional() &
      ref0(functionPrefix) &
      ref0(typeParameters).optional() &
      ref0(formalParameterList) &
      ref0(returnType).optional() &
      ref1(token, ';');

  Parser functionTypeAlias() =>
      ref0(pubToken).optional() &
      ref0(typedefToken) &
      ref0(functionPrefix) &
      ref0(typeParameters).optional() &
      ref0(formalParameterList) &
      ref0(returnType).optional() &
      ref1(token, ';');

  Parser typeAlias() =>
      ref0(pubToken).optional() &
      ref0(typedefToken) &
      ref0(type) &
      ref1(token, '=') &
      ref0(type) &
      ref1(token, ';');

  Parser postfixExpression() =>
      ref0(assignableExpression) & ref0(postfixOperator) |
      ref0(primary) & ref0(selector).star();

  Parser selector() =>
      nullSafetyAnnotations().optional() & ref0(assignableSelector) |
      ref0(arguments);

  Parser nullSafetyAnnotations() => ref1(token, "?") | ref1(token, "!");

  Parser assignableSelector() =>
      (ref1(token, '[') & ref0(expression) & ref1(token, ']') |
          ref1(token, '.') & ref0(identifier)) &
      nullSafetyAnnotations().optional();

  Parser primary() =>
      ref1(token, '&').optional() &
      (ref0(constToken).optional() &
              ref0(typeArguments).optional() &
              ref0(compoundLiteral) |
          (ref0(newToken).optional() | ref0(constToken))
                  .seq(ref0(fnToken).not())
                  .pick(0) &
              ref0(type) &
              ref0(arguments) |
          ref0(functionExpression) |
          ref0(expressionInParentheses) |
          (ref0(thisToken) | ref0(superToken)) &
              ref0(assignableSelector).optional() |
          ref0(literal) |
          ref0(identifier));

  Parser constantExpression() => ref0(expression);

  Parser expression() =>
      (ref0(assignableExpression) &
          (ref0(assignmentOperator) & ref0(expression)).optional()) |
      ref0(conditionalExpression);

  Parser expressionList() => ref0(expression).plusSeparated(ref1(token, ','));

  Parser expressionInParentheses() =>
      ref1(token, '(') & ref0(expression) & ref1(token, ')');

  Parser literal() => ref1(
      token,
      ref0(nullToken) |
          ref0(trueToken) |
          ref0(falseToken) |
          ref0(hexNumberLexicalToken) |
          ref0(numberLexicalToken) |
          ref0(stringLexicalToken) |
          ref0(enumLiteral));

  Parser enumLiteral() => ref1(token, '.') & ref0(identifier);

  Parser compoundLiteral() => ref0(listLiteral) | ref0(mapLiteral);

  Parser listLiteral() =>
      ref1(token, '[') &
      (ref0(expressionList) & ref1(token, ',').optional()).optional() &
      ref1(token, ']');

  Parser mapLiteral() =>
      ref1(token, '{') &
      (ref0(mapLiteralEntry) &
              (ref1(token, ',') & ref0(mapLiteralEntry)).star() &
              ref1(token, ',').optional())
          .optional() &
      ref1(token, '}');

  Parser mapLiteralEntry() =>
      ref1(token, ref0(stringLexicalToken)) &
      ref1(token, ':') &
      ref0(expression);

  Parser functionExpression() =>
      ref0(fnToken) &
      ref0(identifier).optional() &
      ref0(formalParameterList) &
      ref0(returnType).optional() &
      ref0(functionExpressionBody);

  Parser functionPrefix() => ref0(fnToken) & ref0(identifier);

  Parser functionBody() =>
      (ref1(token, '=>') & ref0(block) |
          (ref0(expression) & ref1(token, ';'))) |
      ref0(block);

  Parser functionExpressionBody() =>
      ref1(token, '=>') & (ref0(block) | ref0(expression));

  Parser assignableExpression() =>
      ref0(primary) & (ref0(arguments) | ref0(assignableSelector)).star();

  Parser conditionalExpression() =>
      ref0(logicalOrExpression) &
      (ref1(token, '?') &
              ref0(expression) &
              ref1(token, ':') &
              ref0(expression))
          .optional();

  Parser logicalOrExpression() =>
      ref0(logicalAndExpression) &
      (ref1(token, '||') & ref0(logicalAndExpression)).star();

  Parser logicalAndExpression() =>
      ref0(bitwiseOrExpression) &
      (ref1(token, '&&') & ref0(bitwiseOrExpression)).star();

  Parser bitwiseOrExpression() =>
      ref0(bitwiseXorExpression) &
          (ref1(token, '|') & ref0(bitwiseXorExpression)).star() |
      ref0(superToken) & (ref1(token, '|') & ref0(bitwiseXorExpression)).plus();

  Parser bitwiseXorExpression() =>
      ref0(bitwiseAndExpression) &
          (ref1(token, '^') & ref0(bitwiseAndExpression)).star() |
      ref0(superToken) & (ref1(token, '^') & ref0(bitwiseAndExpression)).plus();

  Parser bitwiseAndExpression() =>
      ref0(equalityExpression) &
          (ref1(token, '&') & ref0(equalityExpression)).star() |
      ref0(superToken) & (ref1(token, '&') & ref0(equalityExpression)).plus();

  Parser equalityExpression() =>
      ref0(relationalExpression) &
          (ref0(equalityOperator) & ref0(relationalExpression)).optional() |
      ref0(superToken) & ref0(equalityOperator) & ref0(relationalExpression);

  Parser relationalExpression() =>
      ref0(shiftExpression) &
          (ref0(isOperator) & ref0(type) |
                  ref0(relationalOperator) & ref0(shiftExpression))
              .optional() |
      ref0(superToken) & ref0(relationalOperator) & ref0(shiftExpression);

  Parser isOperator() => ref0(isToken) & ref1(token, '!').optional();

  Parser shiftExpression() =>
      ref0(additiveExpression) &
          (ref0(shiftOperator) & ref0(additiveExpression)).star() |
      ref0(superToken) &
          (ref0(shiftOperator) & ref0(additiveExpression)).plus();

  Parser additiveExpression() =>
      ref0(multiplicativeExpression) &
          (ref0(additiveOperator) & ref0(multiplicativeExpression)).star() |
      ref0(superToken) &
          (ref0(additiveOperator) & ref0(multiplicativeExpression)).plus();

  Parser multiplicativeExpression() =>
      ref0(unaryExpression) &
          (ref0(multiplicativeOperator) & ref0(unaryExpression)).star() |
      ref0(superToken) &
          (ref0(multiplicativeOperator) & ref0(unaryExpression)).plus();

  Parser unaryExpression() =>
      ref0(postfixExpression) |
      ref0(prefixOperator) & ref0(unaryExpression) |
      ref0(negateOperator) & ref0(superToken) |
      ref1(token, '-') & ref0(superToken) |
      ref0(incrementOperator) & ref0(assignableExpression);

  Parser getOrSet() => ref0(getToken) | ref0(setToken);

  Parser prefixOperator() => ref0(additiveOperator) | ref0(negateOperator);

  Parser postfixOperator() => ref0(incrementOperator);

  Parser negateOperator() => ref1(token, '!') | ref1(token, '~');

  Parser multiplicativeOperator() =>
      ref1(token, '*') |
      ref1(token, '/') |
      ref1(token, '%') |
      ref1(token, '~/');

  Parser assignmentOperator() =>
      ref1(token, '=') |
      ref1(token, '*=') |
      ref1(token, '/=') |
      ref1(token, '~/=') |
      ref1(token, '%=') |
      ref1(token, '+=') |
      ref1(token, '-=') |
      ref1(token, '<<=') |
      ref1(token, '>>>=') |
      ref1(token, '>>=') |
      ref1(token, '&=') |
      ref1(token, '^=') |
      ref1(token, '|=');

  Parser additiveOperator() => ref1(token, '+') | ref1(token, '-');
  Parser incrementOperator() => ref1(token, '++') | ref1(token, '--');

  Parser shiftOperator() =>
      ref1(token, '<<') | ref1(token, '>>>') | ref1(token, '>>');

  Parser relationalOperator() =>
      ref1(token, '>=') |
      ref1(token, '>') |
      ref1(token, '<=') |
      ref1(token, '<');

  Parser equalityOperator() =>
      ref1(token, '===') |
      ref1(token, '!==') |
      ref1(token, '==') |
      ref1(token, '!=');

  Parser bitwiseOperator() =>
      ref1(token, '&') | ref1(token, '^') | ref1(token, '|');

  Parser selectionStatement() =>
      ref0(ifToken) &
          ref1(token, '(') &
          ref0(expression) &
          ref1(token, ')') &
          ref0(statement) &
          (ref0(elseToken) & ref0(statement)).optional() |
      ref0(switchToken) &
          ref1(token, '(') &
          ref0(expression) &
          ref1(token, ')') &
          ref1(token, '{') &
          ref0(switchCase).star() &
          ref0(defaultCase).optional() &
          ref1(token, '}');

  Parser switchCase() =>
      ref0(label).optional() &
      (ref0(caseToken) & ref0(expression) & ref1(token, ':')).plus() &
      ref0(statements);

  Parser defaultCase() =>
      ref0(label).optional() &
      ref0(defaultToken) &
      ref1(token, ':') &
      ref0(statements);

  Parser tryStatement() =>
      ref0(tryToken) &
      ref0(block) &
      (ref0(catchPart).plus() & ref0(finallyPart).optional() |
          ref0(finallyPart));

  Parser catchPart() =>
      ref0(catchToken) &
      ref1(token, '(') &
      ref0(declaredIdentifier) &
      (ref1(token, ',') & ref0(declaredIdentifier)).optional() &
      ref1(token, ')') &
      ref0(block);

  Parser finallyPart() => ref0(finallyToken) & ref0(block);

  Parser asmStatement() =>
      ref0(asmToken) &
      ref0(volatileToken).optional() &
      ref1(token, '(') &
      ref0(stringLexicalToken) &
      ref0(asmFormatParameters).optional() &
      ref1(token, ')') &
      ref1(token, ';');

  Parser asmFormatParameters() =>
      (ref1(token, ',') & ref0(asmFormatParameter)).star();

  Parser asmFormatParameter() =>
      ref0(singleLineStringLexicalToken) &
      ref1(token, ':') &
      ref0(constantExpression);

  // -----------------------------------------------------------------
  // Lexical tokens.
  // -----------------------------------------------------------------
  Parser identifierLexicalToken() =>
      ref0(identifierStartLexicalToken) &
      ref0(identifierPartLexicalToken).star();

  Parser hexNumberLexicalToken() =>
      string('0x') & ref0(hexDigitLexicalToken).plus() |
      string('0X') & ref0(hexDigitLexicalToken).plus();

  Parser numberLexicalToken() =>
      ref0(digitLexicalToken).plus() &
          ref0(numberOptFractionalPartLexicalToken) &
          ref0(exponentLexicalToken).optional() &
          ref0(numberOptIllegalEndLexicalToken) |
      char('.') &
          ref0(digitLexicalToken).plus() &
          ref0(exponentLexicalToken).optional() &
          ref0(numberOptIllegalEndLexicalToken);

  Parser numberOptFractionalPartLexicalToken() =>
      char('.') & ref0(digitLexicalToken).plus() | epsilon();

  Parser numberOptIllegalEndLexicalToken() => epsilon();

  Parser hexDigitLexicalToken() => pattern('0-9a-fA-F');

  Parser identifierStartLexicalToken() =>
      ref0(identifierStartNoDollarLexicalToken) | char('\$');

  Parser identifierStartNoDollarLexicalToken() =>
      ref0(letterLexicalToken) | char('_');

  Parser identifierPartLexicalToken() =>
      ref0(identifierStartLexicalToken) | ref0(digitLexicalToken);

  Parser letterLexicalToken() => letter();

  Parser digitLexicalToken() => digit();

  Parser exponentLexicalToken() =>
      pattern('eE') & pattern('+-').optional() & ref0(digitLexicalToken).plus();

  Parser stringLexicalToken() =>
      char('@').optional() & ref0(multiLineStringLexicalToken) |
      ref0(singleLineStringLexicalToken);

  Parser multiLineStringLexicalToken() =>
      string('"""') & any().starLazy(string('"""')) & string('"""') |
      string("'''") & any().starLazy(string("'''")) & string("'''");

  Parser singleLineStringLexicalToken() =>
      char('"') &
          ref0(stringContentDoubleQuotedLexicalToken).star() &
          char('"') |
      char("'") &
          ref0(stringContentSingleQuotedLexicalToken).star() &
          char("'") |
      string('@"') & pattern('^"\n\r').star() & char('"') |
      string("@'") & pattern("^'\n\r").star() & char("'");

  Parser stringContentDoubleQuotedLexicalToken() =>
      pattern('^\\"\n\r') | char('\\') & pattern('\n\r');

  Parser stringContentSingleQuotedLexicalToken() =>
      pattern("^\\'\n\r") | char('\\') & pattern('\n\r');

  Parser newlineLexicalToken() => pattern('\n\r');

  // -----------------------------------------------------------------
  // Whitespace and comments.
  // -----------------------------------------------------------------
  Parser hiddenStuffWhitespace() =>
      ref0(visibleWhitespace) |
      ref0(singleLineComment) |
      ref0(multiLineComment);

  Parser visibleWhitespace() => whitespace();

  Parser singleLineComment() =>
      string('//') &
      ref0(newlineLexicalToken).neg().star() &
      ref0(newlineLexicalToken).optional();

  Parser multiLineComment() =>
      string('/*') &
      (ref0(multiLineComment) | string('*/').neg()).star() &
      string('*/');
}
