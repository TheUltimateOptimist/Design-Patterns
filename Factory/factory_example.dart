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