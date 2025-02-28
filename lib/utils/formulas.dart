import 'package:math_expressions/math_expressions.dart';

class FormulaEvaluator {
  static String evaluate(String formula, List<List<String>> data) {
    if (formula.startsWith("SUM(")) {
      return _sum(formula, data);
    } else if (formula.startsWith("AVERAGE(")) {
      return _average(formula, data);
    } else if (formula.startsWith("MAX(")) {
      return _max(formula, data);
    } else if (formula.startsWith("MIN(")) {
      return _min(formula, data);
    } else if (formula.startsWith("COUNT(")) {
      return _count(formula, data);
    }
    return _evaluateExpression(formula, data);
  }

  static String _sum(String formula, List<List<String>> data) {
    return _calculateAggregate(formula, data, (values) => values.reduce((a, b) => a + b));
  }

  static String _average(String formula, List<List<String>> data) {
    return _calculateAggregate(formula, data, (values) => values.reduce((a, b) => a + b) / values.length);
  }

  static String _max(String formula, List<List<String>> data) {
    return _calculateAggregate(formula, data, (values) => values.reduce((a, b) => a > b ? a : b));
  }

  static String _min(String formula, List<List<String>> data) {
    return _calculateAggregate(formula, data, (values) => values.reduce((a, b) => a < b ? a : b));
  }

  static String _count(String formula, List<List<String>> data) {
    return _calculateAggregate(formula, data, (values) => values.length.toDouble());
  }

  static String _calculateAggregate(String formula, List<List<String>> data, double Function(List<double>) operation) {
    List<String> range = formula.replaceAll(RegExp(r'\w+\('), "").replaceAll(")", "").split(":");
    if (range.length == 2) {
      int startRow = int.parse(range[0].substring(1)) - 1;
      int endRow = int.parse(range[1].substring(1)) - 1;
      int col = range[0][0].codeUnitAt(0) - 65;
      List<double> values = [];
      for (int i = startRow; i <= endRow; i++) {
        double? val = double.tryParse(data[i][col]);
        if (val != null) values.add(val);
      }
      return values.isNotEmpty ? operation(values).toString() : "0";
    }
    return "Invalid Range";
  }

  static String _evaluateExpression(String expression, List<List<String>> data) {
    expression = _replaceCellReferences(expression, data);
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      return "Error";
    }
  }

  static String _replaceCellReferences(String expression, List<List<String>> data) {
    RegExp regex = RegExp(r'([A-Z]+)([0-9]+)');
    return expression.replaceAllMapped(regex, (match) {
      String colRef = match.group(1)!;
      int rowRef = int.parse(match.group(2)!) - 1;
      int colIndex = colRef.codeUnitAt(0) - 65;
      if (rowRef >= 0 && rowRef < data.length && colIndex >= 0 && colIndex < data[0].length) {
        return data[rowRef][colIndex];
      }
      return "0";
    });
  }
}