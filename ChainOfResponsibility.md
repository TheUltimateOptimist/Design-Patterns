# Chain of Responsibility

- ## Intent:
  Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request. Chain the receiving objects and pass the request along the chain until an object handles it.

- ## How it works:
  Create an abstract Handler class. It defines an interface for handling requests. Next create ConcreteHandler classes that implement the Handler handling requests they are responsible for. They can also access their successor, to whom they will forward a request that they can not handle. The client lastly simply initiates the request to a ConcreteHandler object on the chain.
  

- ## Use when:
  - more than one object might handle a request, and the handle is not known a priori. The handler should be ascertained automatically.
  - you want to issue a request to one of several objects without specifying the receiver explicitly
  - the set of objects that can handle a request should be specified dynamically

- ## Benefits:
  - reduced coupling
  - added flexibility in assigning responsibilities to objects

- ## SideNote:
  In flutter, widgets can dispatch Notifications which can be caught anywhere in the widget tree using a NotificationListener. That is a very good example for the Chain of Responsibility.

- ## Structure:
  ![class diagram](https://miro.medium.com/max/491/1*A-RUUrXZtJmW5ImF853Xsg.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/ChainOfResponsibility/chain_of_responsibility_example.dart)

  ```
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
  ```