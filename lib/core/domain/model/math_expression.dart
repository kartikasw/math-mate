class MathExpression {
  String expression;

  MathExpression(this.expression);

  void replaceAll(Pattern from, String replace) {
    expression = expression.replaceAll(from, replace);
  }
}
