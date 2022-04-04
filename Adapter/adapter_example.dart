void main(List<String> args) {
  Figure humanOne = FirstHumanAdapter();
  Figure humanTwo = SecondHumanAdapter(Human());
  humanOne.printArea();
  humanTwo.printArea();
  humanOne.printNumberOfEdges();
  humanTwo.printNumberOfEdges();
}

abstract class Figure {
  void printArea();
  void printFigureDescription();
  void printNumberOfEdges();
}

class Human {
  void printName() {
    print("Hello, I am Fritz.");
  }

  void printHeight() {
    print("180 cm");
  }

  void printPersonality() {
    print("I am a very easy to work with person");
  }
}

//Adapter using inheritance
class FirstHumanAdapter extends Human implements Figure {
  @override
  void printArea() {
    printHeight();
  }

  @override
  void printFigureDescription() {
    printName();
  }

  @override
  void printNumberOfEdges() {
    printPersonality();
  }
}

//Adapter using object composition
//Advantage: Adapter also works for subclasses of Human
class SecondHumanAdapter implements Figure {
  SecondHumanAdapter(this.human);

  final Human human;

  @override
  void printArea() {
    human.printHeight();
  }

  @override
  void printFigureDescription() {
    human.printName();
  }

  @override
  void printNumberOfEdges() {
    human.printPersonality();
  }
}
