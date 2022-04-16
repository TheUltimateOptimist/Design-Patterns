# Visitor

- ## Intent:
  Represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
  
- ## How it works:
  Create an abstract Element class that defines an abstract accept operation that takes a visitor as an argument. Next define ConcreteElement classes which implement the abstract accept operation. These two types of classes together from the object structure. To define operation for this object structure you need to: First, create an abstract Visitor class that declares an abstract visit operation for each class of ConcreteElement in the object structure. Second, create ConcreteVisitor classes that implement each opeartion declared by the Visitor class thereby forming one operation that can be performed on the whole object structure. Each ConcreteVisitor class is also responsible for storing any local state needed when the object structure is being traversed. The buildup described above lets you easily add new operations for the whole object structure, simply by creating a new sub class of Visitor.
  
- ## Use when:
  - an object structure contains many classes of objects with differing interfaces, and you want to perform operations on these objects that depend on their concrete classes.
  - many distinct and unrelated operations need to be performed on objects in an object structure, and you want to avoid polluting their classes with these operations. Visitor lets you keep related operations together by dfining them in one class.
  - the classes defining the object structure rarely change, but you often want to define new operations over the structure.

- ## Consequences:
  - adding new operations becomes easy
  - it gathers related operations and seperates unrelated ones
  - adding new concrete element classes becomes hard
  - it can visit any classes
  - it can accumulate state
  - Visitor's approach assumes that the ConcreteElement interface is powerful enough to let visitors do their job. As a result, the pattern often forces you to provide public operations that access an element's internal state, which may compromise its encapsulation
  

- ## Structure:
  ![class diagram](https://www.researchgate.net/profile/Jeremy-Gibbons/publication/221321664/figure/fig1/AS:647144079900683@1531302580930/The-VISITOR-design-pattern.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Visitor/visitor_example.dart)

  ```
  void main(List<String> args) {
    List<Human> objectStructure = [
      Girl("Lisa", 15),
      Woman("Lydia", 40),
      Boy("Jonathan", 19),
      Man("Peter", 42),
    ];
    traverseObjectStructure(objectStructure, ReceiveIncome());
    traverseObjectStructure(objectStructure, MoneyPrinter());
    print("");
    traverseObjectStructure(objectStructure, ReceiveIncome());
    traverseObjectStructure(objectStructure, MoneyPrinter());
  }

  void traverseObjectStructure(List<Human> objectStructure, Visitor v) {
    for (var human in objectStructure) {
      human.accept(v);
    }
  }

  //Visitor
  abstract class Visitor {
    void visitMan(Man man);
    void visitWoman(Woman woman);
    void visitGirl(Girl girl);
    void visitBoy(Boy boy);
  }

  //Concrete Visitor
  class ReceiveIncome implements Visitor {
    @override
    void visitBoy(Boy boy) {
      boy.money += 400;
    }

    @override
    void visitGirl(Girl girl) {
      girl.money += 500;
    }

    @override
    void visitMan(Man man) {
      man.money += 2400;
    }

    @override
    void visitWoman(Woman woman) {
      woman.money += 2000;
    }
  }

  //Concrete Visitor
  class MoneyPrinter extends Visitor {
    @override
    void visitBoy(Boy boy) {
      print("Boy ${boy.name} has ${boy.money} Euro");
    }

    @override
    void visitGirl(Girl girl) {
      print("Girl ${girl.name} has ${girl.money} Euro");
    }

    @override
    void visitMan(Man man) {
      print("Man ${man.name} has ${man.money} Euro");
    }

    @override
    void visitWoman(Woman woman) {
      print("Woman ${woman.name} has ${woman.money} Euro");
    }
  }

  //Element
  abstract class Human {
    Human(this.name, this.age);

    String name;

    int age;

    double money = 0;

    void accept(Visitor visitor);
  }

  //Concrete Element
  class Man extends Human {
    Man(String name, int age) : super(name, age);

    @override
    void accept(Visitor visitor) {
      visitor.visitMan(this);
    }
  }

  //Concrete Element
  class Woman extends Human {
    Woman(String name, int age) : super(name, age);

    @override
    void accept(Visitor visitor) {
      visitor.visitWoman(this);
    }
  }

  //Concrete Element
  class Girl extends Human {
    Girl(String name, int age) : super(name, age);

    @override
    void accept(Visitor visitor) {
      visitor.visitGirl(this);
    }
  }

  //Concrete Element
  class Boy extends Human {
    Boy(String name, int age) : super(name, age);

    @override
    void accept(Visitor visitor) {
      visitor.visitBoy(this);
    }
  }
  ```