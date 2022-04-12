void main(List<String> args) {
  Calculator calculator = Calculator();
  print(calculator.calculate(2, 2, "+"));
  print(calculator.calculate(2, 2, "-"));
  print(calculator.calculate(2, 2, "*"));
  print(calculator.calculate(2, 2, "/"));
  print(calculator.calculate(2, 2, "hsdhjk"));
}

abstract class CalculationHandler {
  double calculate(double a, double b, String operator);
}

class Calculator {
  CalculationHandler handler = Adder();
  double calculate(double a, double b, String operator){
    return handler.calculate(a, b, operator);
  }
}

class Adder implements CalculationHandler {
  CalculationHandler successor = Subtracter();

  @override
  double calculate(double a, double b, String operator) {
    if (operator == "+") {
      return a + b;
    }
    return successor.calculate(a, b, operator);
  }
}

class Subtracter implements CalculationHandler {
  CalculationHandler successor = Multiplier();

  @override
  double calculate(double a, double b, String operator) {
    if (operator == "-") {
      return a - b;
    }
    return successor.calculate(a, b, operator);
  }
}

class Multiplier implements CalculationHandler {
  CalculationHandler successor = Divider();

  @override
  double calculate(double a, double b, String operator) {
    if (operator == "*") {
      return a * b;
    }
    return successor.calculate(a, b, operator);
  }
}

class Divider implements CalculationHandler {
  @override
  double calculate(double a, double b, String operator) {
    if (operator == "/") {
      return a / b;
    }
    throw UncaughtRequestException();
  }
}

class UncaughtRequestException implements Exception {}
