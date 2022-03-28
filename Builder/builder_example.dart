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