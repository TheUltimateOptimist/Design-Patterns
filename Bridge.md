# Bridge

- ## Intent:
  Decouple an abstraction from its implementation so that the two can vary independently

- ## How it works:
  Create an abstract class that has to be configured with an instance of the abstract Implementor class. The abstract class then defers all of its operation calls to the implementator instance.
  The abstract Implementator class has to be extended to specify concrete Impelentators. The abstract class mentioned in the beginning has to also be extended to provide concrete abstraction classes the client can instantiate.
  
- ## Use when:
  - you want to avoid permanent binding between an abstraction and its implemenmtation. For example when the implementation must be switched or selected at runtime.
  - the abstractions and the implementations should be extensible by subclassing
  - changes in the implementation should of an abstraction should have no impact on clients. Means, there code should not have to be recompiled.
  - you have a proliferation of classes. Means, when subclassing the amount of subclasses required grows fast.
  - you want to share an implementation among multiple objects

- ## Benefits:
  - ### decouples interface and implementation   
    an implementation is not bound permanently to an interface
  - ### improved extensability
    the abstraction and implementator hierarchies can be extended independently
  - ### hiding implementation details from clients  
    
- ## Structure:
  ![class diagramm](https://www.dofactory.com/img/diagrams/net/bridge.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Adapter/adapter_example.dart)
  ```
  void main(List<String> args) {
    WordPrinterImplementation german = GermanWordPrinter();
    WordPrinterImplementation english = EnglishWordPrinter();
    SingleWordPrinter singleWordPrinter = SingleWordPrinter(german);
    MultipleWordPrinter multipleWordPrinter = MultipleWordPrinter(english);
    singleWordPrinter.printWord();
    print("--------------");
    multipleWordPrinter.printWords();
  }

  abstract class WordPrinter {
    WordPrinter(this.implementation);
    WordPrinterImplementation implementation;
    void printWord() {
      implementation.printWord();
    }
  }

  class SingleWordPrinter extends WordPrinter {
    SingleWordPrinter(WordPrinterImplementation implementation)
        : super(implementation);
  }

  class MultipleWordPrinter extends WordPrinter {
    MultipleWordPrinter(WordPrinterImplementation implementation)
        : super(implementation);

    void printWords() {
      for (int i = 0; i < 10; i++) {
        printWord();
      }
    }
  }

  abstract class WordPrinterImplementation {
    void printWord();
  }

  class GermanWordPrinter implements WordPrinterImplementation {
    @override
    void printWord() {
      print("Hallo");
    }
  }

  class EnglishWordPrinter implements WordPrinterImplementation {
    @override
    void printWord() {
      print("Hello");
    }
  }
  ```