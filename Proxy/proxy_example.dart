void main(List<String> args) {
  //creates the proxy, human object will be created later
  Creature human = HumanProxie();
  
  //now human object will be created(at first access)
  human.increaseAge();
}

abstract class Creature<T> {
  void increaseAge();
  void changeName(String newName);
}

class Human implements Creature {
  Human(this._name, this._age);

  String _name;

  int _age;

  @override
  void changeName(String newName) {
    _name = newName;
  }

  @override
  void increaseAge() {
    _age++;
  }
}

class HumanProxie implements Creature {
  Human? human;

  @override
  void changeName(String newName) {
    if(human == null){
      human = Human("Fritz Heinz", 30);
    }
    human!.changeName(newName);
  }

  @override
  void increaseAge() {
    if(human == null){
      human = Human("Fritz Heinz", 30);
    }
    human!.increaseAge();
  }
}
