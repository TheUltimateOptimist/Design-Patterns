# Strategy

- ## Intent:
  Define the skeleton of an algorithm in an operation, deferring some steps to subclasses. Template Method lets subclasses redefine certain steps of an alogorithm without changing the algorithm's structure.

- ## How it works:
  Define an abstract class that holds one templateMethod() and as many abstract primitive operations as you like. The abstract primitive operations are used in the non-abstract templateMethod() to implement the given algorithm. Classes can then extend the abstract class and change the algorithm by overriding the abstract primitive operations.

- ## Hooks vs abstract operations:
  Hooks can be overriden whereas abstract operations must be overriden.

- ## Use when:
  - you want to implement the invariant parts of an algorithm once and leave it up to subclasses to implement the behaviour that can vary
  - common behaviour among subclasses should be factored and localized in a common class to avoid code duplication
  - you want to control subclasses extensions. You can define a template method that calls "hook" operations at specific points, thereby permitting extensions only at those points

- ## Structure:
  ![class Diagramm](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcgObKp_1v6swf3K4I3gc6mF8tq845sR1rfA&usqp=CAU)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/TemplateMethod/template_method_example.dart)

  ```
  void main(List<String> args) {
    Multiplier normal = NormalMultiplier();
    Multiplier absurd = AbsurdMultiplier();
    print("5*5 normal: ${normal.multiplyPositiveNumbers(5,5)}}");
    print("5*5 absurd: ${absurd.multiplyPositiveNumbers(5,5)}}");
  }

  abstract class Multiplier{
    int multiplyPositiveNumbers(int a, int b){
      int result = 0;
      for(int i = 0; i < a; i++){
        result = add(result, b);
      }
      return result;
    }

    int add(int a, int b);
  }

  class NormalMultiplier extends Multiplier{
    @override
    int add(int a, int b) {
      return a + b;
    }
  }

  class AbsurdMultiplier extends Multiplier{
    @override
    int add(int a, int b) {
      return a*b;
    }
  }
  ```