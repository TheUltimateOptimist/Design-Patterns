void main(List<String> args) {
  AnimalFactory factoryOne = EarthAnimalFactory();
  AnimalFactory factoryTwo = AlienAnimalFactory();
  factoryOne.createDog().bark();
  factoryTwo.createDog().bark();
  factoryOne.createCat().tellAge();
  factoryTwo.createCat().tellAge();
}

abstract class AnimalFactory{
  Dog createDog();
  Cat createCat();
}

class EarthAnimalFactory implements AnimalFactory{

  @override
  Cat createCat() {
    return EarthCat();
  }

  @override
  Dog createDog() {
    return EarthDog();
  }

}

class AlienAnimalFactory implements AnimalFactory{

  @override
  Cat createCat() {
    return AlienCat();
  }

  @override
  Dog createDog() {
    return AlienDog();
  }

}

abstract class Dog{
  void bark();
}

abstract class Cat{
  void tellAge();
}

class EarthDog implements Dog{
  @override
  void bark() {
    print("WauWau");
  }
}

class EarthCat implements Cat{

  @override
  void tellAge() {
    print("I am 3 years old");
  }
}

class AlienDog implements Dog{

  @override
  void bark() {
    print("Wohohohoho");
  }
}

class AlienCat implements Cat{

  @override
  void tellAge() {
    print("I am infinetely old");
  }
}