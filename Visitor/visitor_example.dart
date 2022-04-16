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
