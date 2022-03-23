# Factory Method

- ## Intent
  Define an interface for creating an object, but let subclasses decide which class to instantiate.

- ## How it works:
  Define a Crator interface that holds the factoryMethod. Then SpecialCreators implement the creator interface overriding the factoryMethod returning a concrete object.

- ## Use when:
  - you want to create an object that has to a lot of dependencies and configuration to be done
  - a class can not anticipate the class of objects it must create
  - a class wants its subclasses to specify the objects it creates

- ## Implementation optioins:
  - you can let the Crator class be a concrete class offering a default implementation for the factory method
  - you can let the factoryMethod take a parameter and produce multiple types of objects based on that

- ## Code Example
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/FactoryMethod/factory_method_example.dart)

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