# Facade

- ## Intent:
  Provide a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.

- ## How it works:
  Let's say you have a subsystem with several different classes working together to achiev some goal. A client will have to know of all of these classes. To reduce complexity you can use a facade class that defines one interface for the client to use handling the work with all subsystems classes. This way the client will only have to deal with the facades interface. 

- ## Use when:
  - you want to provide a simple interface to a complex subsystem
  - there are many dependencies between clients and the implementation classes of an abstraction. Introduce a facade to decouple the subsystem from clients and other subsystems.
  - you want to layer your subsystems

- ## Benefits:
  - it shields clients from subsystem components, thereby reducing the number of objects that clients deal with and making the subsystem easier to use
  - it promotes weak coupling between the subsystem and its clients(subsystem changes won't affect the client)
  - it does not prevent clients from using subsystem classes if they need to

- ## Sidenote:
  The flutter framework makes heavy use of the Decorator pattern. For example when you wrap a widget with Positioned widget to set its position in the given constraints.

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Facade/facade_example.dart)

      void main(List<String> args) {
        //if client wants to print hello world he only needs to know the printer class
        //he does not need to deal with the subsystem classes HelloPrinter and WorldPrinter
        Printer().printHelloWorld();
      }

      class Printer{
        printHelloWorld(){
          HelloPrinter().printHello();
          WorlPrinter().printWorld();
        }
      }

      class HelloPrinter{
        void printHello(){
          print("Hello");
        }
      }

      class WorlPrinter{
        void printWorld(){
        print("World");
        }
      }