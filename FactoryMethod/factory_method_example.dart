void main(List<String> args) {
  Animal dog = DogCreator().create();
  dog.makeNoise();
  Animal cat = CatCreator().create();
  cat.makeNoise();
}

abstract class Creator{
  Animal create();
}

class DogCreator extends Creator{

  @override
  Animal create() {
    return Dog("dog");
  }
}

class CatCreator extends Creator{

  @override
  Animal create() {
    return Cat("cat");
  }

}

abstract class Animal {
  String name;

  Animal(this.name);

  void makeNoise();
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeNoise() {
    print("WauWau");
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeNoise() {
    print("Miauuu");
  }
}
