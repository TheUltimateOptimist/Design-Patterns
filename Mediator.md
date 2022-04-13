# Mediator

- ## Intent:
  Define an object that encapsulates how a set of objects interact. Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you  vary their interaction independently.

- ## How it works:
  First, create an abstract mediator class if there will be more than one mediator. It defines an interface for communicating with Colleague objects. Second, create create ConcreteMediator classes that implement cooperative behaviour by coordinating Colleague objects, besides knowing and maintaining its colleagues. Lastly, create Colleague classes. Each one knows its Mediator object and communicates with its mediator when it would have communicated with another colleague otherwise.
  

- ## Use when:
  - a set of objects communicate in well-defined but complex ways. The resulting interdependencies are unstructured and difficult to understand.
  - reusing an object is difficult because it refers to and communicates with many other objects
  - a behaviour that's distributed between several classes should be customizable without a lot of subclassing.

- ## Benefits:
  - it limits subclassing. A mediator localizes behaviour that otherwise would be distributed among several objects. Changing this behaviour requires subclassing Mediator only; Colleague classes can be reused as is
  - it decouples collegues. A mediator promotes loose coupling between colleagues. You can vary and reuse Colleague and Mediator classes independently.
  - it simplifies object protocols. A mediator replaces many-to-many interactions with one-to-many interactions between the mediator and its collegues. One-to-many relationships are easier to understand, maintain, and extend
  - it abstracts how objects cooperate. Making mediation an independent concept and encapsulating it in an object lets you focus on how objects interact apart from their individual behaviour. That can help clarify how objects interact in a a system.

- ## Danger
  The Mediator centralizes control. It trades complexity of interaction for complexity in the mediator. Because a mediator encapsulates protocols, it can become more complex than any other individual colleague. This can make the mediator itself a monolith that's hard to maintain.

- ## Structure:
  ![class diagram](https://www.dofactory.com/img/diagrams/net/mediator.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/ChainOfResponsibility/mediator_example.dart)

    ```
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
    ```