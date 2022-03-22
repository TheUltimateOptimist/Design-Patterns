# Strategy

## Intent:
Define algorithms or behaviors independent from the clients that use it

## How it works:
One algorithm interface is created. Then all different implementations of that algorithm are encapsulated in its own class that implements the interface. Classes that need the algorithm store an instance of the algorithm interface.

## Use when:
- Many related classes differ only in their behaviour. Strategies provide a good way to configure each class with one of many behaviours
- different variants of one algorithm/behaviour are needed
- an algorithm uses data clients should not know about
- when there are many different behaviours in one class as part of multiple  conditional statements

## Example Code:
    void main(List<String> args) {
      Calculator normalCalculator = Calculator(AddNormal());
      Calculator absurdCalculator = Calculator(AddAbsurd());
      print(normalCalculator.add(1, 1));
      print(absurdCalculator.add(1, 1));
    }

    class Calculator {
      Adding addingType;
      Calculator(this.addingType);

      double add(double a, double b) {
        return addingType.add(a, b);
      }
    }

    abstract class Adding {
      double add(double a, double b);
    }

    class AddNormal implements Adding {
      @override
      double add(double a, double b) {
        return a + b;
      }
    }

    class AddAbsurd implements Adding {
      @override
      double add(double a, double b) {
        return a + b + 10;
      }
    }