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
