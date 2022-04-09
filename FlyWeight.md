# FlyWeight

- ## Intent:
  Use sharing to support large numbers of fine-grained objects efficiently

- ## What is a FlyWeight:
  A FlyWeight is a shared object that can be used in multiple contexts simultaneously. It acts as an independent object in each context-it's indistuangishable from an instance of the object that's not shared. FlyWeights cannot make assumptions about the context in which they operate. The key concept here is the distiction between *intrinsic* and *extrinsic* state. Intrinsic state is stored in the FlyWeight; it consists of information that's independent of the FlyWeight's context thereby making it sharable. Extrensic state depend's on and varies with the FlyWeight's context and therefore can not be shared. Client objects are responsible for passing extrinsic state to the FlyWeight when it needs it.

- ## How it works:
  First create an abstract FlyWeight class that declares an interface through which flyweights can receive and act on extrinsic state. Second create some ConcreteFlyWeight classes that implement the FlyWeight interface and add storage for intrinsic state if any. Third create some UnsharedConcreteFlyWeight classes if needed. Lastly you need to create a FlyWeightFactory that creates and manages FlyWeight objects. It ensures that FlyWeights are shared properly. When a client requests a FlyWeight, it supplies an existing instance or creates one, if none exists. The client then maintains a reference to the FlyWeight(s) and computes or stores the extrinsic state of the FlyWeight(s).
  
- ## Use when all the following are true:
  - an application uses a large number of objects
  - storage costs are high because of the sheer quantity of objects
  - most object state can be made extrinsic
  - many groups of objects may be replaced by relatively few shared objects once extrinsic state is removed
  - the application does not append on object identity
  

- ## Benefits:
  - saves memory
  
- ## Structure:
  ![class diagramm](https://miro.medium.com/max/1200/1*d2IDQYmGM8uVqR4mjHYlBQ.png)
  
- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/FlyWeight/fly_weight_example.dart)

  ```
  import 'dart:math';

  void main(List<String> args) {
    CharacterFactory characterFactory = CharacterFactory();
    TelephoneNumber telNumber = TelephoneNumber.fromRandom(15, characterFactory);
    telNumber.printNumber();
    telNumber.addCharacter(9);
    telNumber.addCharacter(9);
    telNumber.printNumber();
  }

  class InvalidKeyException implements Exception{
  }

  //client class
  class TelephoneNumber{
    List<Character> _characters;

    CharacterFactory _characterFactory;

    TelephoneNumber(this._characters, this._characterFactory);

    factory TelephoneNumber.fromRandom(int numberOfDigits, CharacterFactory characterFactory){
      final List<Character> characters = List.empty(growable: true);
      characters.add(characterFactory.getCharacter(-1));
      for(int i = 0;i < numberOfDigits; i++){
        final randomInt = Random().nextInt(10);
        characters.add(characterFactory.getCharacter(randomInt));
      }
      return TelephoneNumber(characters, characterFactory);
    }

    void addCharacter(int key){
      _characters.add(_characterFactory.getCharacter(key));
    }

    void printNumber(){
      String result = "";
      for(int i = 0; i < _characters.length; i++){
        if(i % 5 == 0){
          result+=_characters[i].getString(true);
        }
        else{
          result+=_characters[i].getString(false);
        }
      }
      print(result);
    }

  }

  //FlyWeight factory
  class CharacterFactory{
    Map<int, Character> characters = {};

    Character getCharacter(int key){
      if(key == -1) return Plus();
      switch(key){
        case 0: return characters.putIfAbsent(key, () => Number("0"));
        case 1: return characters.putIfAbsent(key, () => Number("1"));
        case 2: return characters.putIfAbsent(key, () => Number("2")); 
        case 3: return characters.putIfAbsent(key, () => Number("3"));
        case 4: return characters.putIfAbsent(key, () => Number("4"));
        case 5: return characters.putIfAbsent(key, () => Number("5"));
        case 6: return characters.putIfAbsent(key, () => Number("6"));
        case 7: return characters.putIfAbsent(key, () => Number("7"));
        case 8: return characters.putIfAbsent(key, () => Number("8"));
        case 9: return characters.putIfAbsent(key, () => Number("9"));
        default: throw InvalidKeyException();
      }
    }
  }

  //FlyWeight
  abstract class Character{
    String getString(bool putSpaceAround);
  }

  //Shared Concrete FlyWeight
  class Number implements Character{
    Number(this.value);

    final String value;

    @override
    String getString(bool putSpaceAround) {
      if(putSpaceAround){
        return " $value ";
      }
      return value;
    }
  }

  //Unshared Concrete FlyWeight
  class Plus implements Character{
    @override
    String getString(bool putSpaceAround) {
      if(putSpaceAround){
        return "+ ";
      }
      return "+";
    }
  }
  ```