# Abstract Factory

- ## Intent:
  Provide an interface for creating families of related or dependent objects without specifiying their concrete classes

- ## How it works:
  First you need an interface(Abstract Factory) for operations that create abstract product objects.
  Second you need to implement a Concrete Factory that implements these operations. In addition an AbstractProduce class
  is required which declares an interface for a type of product object. Furthermore a ConcreteProduct class is needed for
  implementing the AbstractProduct interface defining the concrete product. The client can then create objects only needing to know
  of the AbstractFactory and AbstractProduct interface.

- ## Use when:
  - a system should be independent of how its products are created, composed or represented
  - a system should be configured with one of multiple families of products
  - a family of related product objects is designed to be used together and you want to enforce this constraint
  - you want to reveal just the interfaces of the products and not their implementations

- ## Implementation tips:
  - implement concrete factorys as singletons as applications usually only need one kind of factory per product family
  - the concrete factorys can create the products using the factory method pattern
  - alternativly, if many different product families are possible, the abstract facotry can be implemented with the prototype pattern

- ## Structure:
  ![class diagram](https://narbase.com/wp-content/uploads/2020/06/SecondImage-700x328.jpeg)

- ## Code Example:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/AbstractFactory/abstract_factory_example.dart)

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