# Adapter

- ## Intent:
  Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces

- ## How it works:
  - class adapter:
    If you have a class x and an interface y which do not work togther but a client expects the interface y when using class x you can create a class adapter by creating a class that extends class x and implements interface y. That way the client can use the adapter for class x instead of class x being exposed to the expected interface.
  - object adapter:
    The object adapter works very much like the class adapter. But this time the adapter class does not extend the adaptee. Instead it holds a reference to an instance of it.
  
- ## Use when:
  - you want to use an existing class, but its interface does not match the one you need
  - you want to create a reusable class that cooperates with unrelated or unforeseen classes that is classes that don't necessarily have compatible interfaces
  - (object adapter only) you need to use several existing subclasses, but it is impractical to adapt their interface by subclassing every one. An object adapter can adapt the interface of its parent class

- ## Structure:
  ![class diagram](https://miro.medium.com/max/974/1*CYQa922OwV3zgt2Xv_luEA.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Adapter/adapter_example.dart)

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

