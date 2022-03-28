# Builder

- ## Intent:
  Seperate the construction of a complex object from its representation so that the same contruction process can create different representations

- ## How it works:
  First, define a Builder interface that exposes methods for building parts of the desired product and retrieving it. Second, implement a ConcreteBuilder class that implements the Builder interface and contains the instancd of the product it constructs. Moreover you need a Director class that is configured with a ConcreteBuilder. This class can then be used by the client to construct the desired Product using the ConcreteBuilder it has been configured with.
  

- ## Use when:
  - the algorithm for creating a complex object should be independent of the parts that make up the object and how they are assembled
  - the construction process must allow different representations for the object that's constructed

- ## Benefits:
  - It lets you vary a product's internal representation
    All you have to do to change the internal representation of a product is define a new kind of builder
  - It isolates code for construction and representation
  - It gives you finer control over the construction process
    Apart from other creational patterns the builder does not create the products in one shot but one step at a time. This gives you more control over the construction process
  

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Builder/builder_example.dart)

      void main(List<String> args) {
        HumanBuilder youngHumanBuilder = YoungHumanBuilder();
        HumanBuilder oldHumanBuilder = OldHumanBuilder();
        Human youngHuman = HumanBuilderDirector(youngHumanBuilder).construct();
        Human oldHuman = HumanBuilderDirector(oldHumanBuilder).construct();
        print(youngHuman.age);
        print(oldHuman.age);
      }

      class Human{
        late String hairColor;
        late double height;
        late int age;
        late String sex;
      }

      abstract class HumanBuilder{
        void defineHair();
        void defineHeight();
        void defineAge();
        void defineSex();
        Human getHuman();
      }

      class HumanBuilderDirector{
        HumanBuilder humanBuilder;

        HumanBuilderDirector(this.humanBuilder);

        Human construct(){
          humanBuilder.defineHair();
          humanBuilder.defineAge();
          humanBuilder.defineHeight();
          humanBuilder.defineSex();
          return humanBuilder.getHuman();
        }
      }

      class OldHumanBuilder implements HumanBuilder{

        late Human human;

        OldHumanBuilder(){
          human = Human();
        }

        @override
        void defineAge() {
          human.age = 80;
        }

        @override
        void defineHair() {
          human.hairColor = "blond";
        }

        @override
        void defineHeight() {
          human.height = 190;
        }

        @override
        void defineSex() {
          human.sex = "male";
        }

        @override
        Human getHuman() {
          return human;
        }
      }

      class YoungHumanBuilder implements HumanBuilder{

        late Human human;

        YoungHumanBuilder(){
          human = Human();
        }

        OldHumanBuilder(){
          human = Human();
        }

        @override
        void defineAge() {
          human.age = 20;
        }

        @override
        void defineHair() {
          human.hairColor = "black";
        }

        @override
        void defineHeight() {
          human.height = 190;
        }

        @override
        void defineSex() {
          human.sex = "male";
        }

        @override
        Human getHuman() {
          return human;
        }
      }

