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