# Factory

- ## Intent:
  Encapsulate the conditional creation of different objects that share a common super class 

- ## How it works:
  Create a factory class that has a method that can be called for object creation. This method then returns the proper object. The proper object is chosen at runtime.

- ## Use when:
  - you do not know ahead of time which class object you need
  - all of the potential classes are in the same subclass hierarchy
  - you want to centralize class selection code
  - you do not want the client to need to know every subclass
  - you want to encapsulate object creation

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Factory/factory_example.dart)

      void main(List<String> args) {
        Animal animal = AnimalFactory().getAnimal(args[0]);
        animal.makeNoise();
      }

      class AnimalFactory{
        Animal getAnimal(String name){
          if(name == "cat"){
            return Cat(name);
          }
          else if(name == "dog"){
            return Dog(name);
          }
          throw Exception("Error: The name " + name + " is unknown!");
        }
      }

      abstract class Animal{
        String name;
        
      Animal(this.name);

        void makeNoise();
      }

      class Dog extends Animal{
        Dog(String name) : super(name);

        @override
        void makeNoise() {
          print("WauWau");
        }
      }

      class Cat extends Animal{
        Cat(String name) : super(name);

        @override
        void makeNoise() {
          print("Miauuu");
        }
      }
