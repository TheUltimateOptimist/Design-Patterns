void main(List<String> args) {
  UnitMediator mediator = UnitMediator();
  Unit kilometer = Kilometer(mediator);
  Unit meter = Meter(mediator);
  Unit dezimeter = Dezimeter(mediator);
  mediator.printUnits();
  kilometer.updateValue(1);
  mediator.printUnits();
  dezimeter.updateValue(1);
  mediator.printUnits();
}

class InvalidUnitException implements Exception{
}

class UnitMediator{
  List<Unit> units = [];

  UnitMediator();

  void changeCollegues(Unit unitChanged){
    final double newValueInM;
    switch(unitChanged.runtimeType){
      case Kilometer: newValueInM = unitChanged.currentValue*1000;
      break;
      case Meter: newValueInM = unitChanged.currentValue;
      break;
      case Dezimeter: newValueInM = unitChanged.currentValue/10;
      break;
      default: throw InvalidUnitException();
    }
    for(var unit in units){
      if(unit != unitChanged){
        unit.convertFrom(newValueInM);
      }
    }   
  }

  void printUnits(){
    print("----");
    for(var unit in units){
      print(unit.toString());
    }
    print("-----");
  }
}

abstract class Unit{

  UnitMediator mediator;

  double currentValue;

  Unit(this.mediator, this.currentValue){
    mediator.units.add(this);
  }

  void updateValue(double newValue){
    currentValue = newValue;
    mediator.changeCollegues(this);
  }

  void convertFrom(double meters);
}

class Kilometer extends Unit{
  Kilometer(UnitMediator mediator) : super(mediator, 0.001);

  @override
  void convertFrom(double meters) {
    currentValue = meters/1000;
  }

   @override
  String toString() {
    return "km: $currentValue";
  }
}

class Meter extends Unit{
  Meter(UnitMediator mediator) : super(mediator, 1);

  @override
  void convertFrom(double meters) {
    currentValue = meters;
  }

  @override
  String toString() {
    return "m: $currentValue";
  }
}

class Dezimeter extends Unit{
  Dezimeter(UnitMediator mediator) : super(mediator, 10);

  @override
  void convertFrom(double meters) {
    currentValue = meters*10;
  }

  @override
  String toString() {
    return "dm: $currentValue";
  }
}