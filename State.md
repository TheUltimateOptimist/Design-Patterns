# Iterator

- ## Intent:
  Allow an object to alter its behaviour when its internal state changes. The Object will appear to change its class.

- ## How it works:
  First you define the class with the variying state that defines the interface of interest to clients and maintains an instance of a ConcreteState subclass that defines the current state. Next you create the abstract State class which defines an interface for encapsulating the behaviour associated with a particular state. Next ConcreteState subclasses implement the State class defining a behaviour associated with a specific state.
  
- ## Use when:
  - An object's behaviour depends on its state, and it must change its behaviour at run-time depending on that state
  - Operations have large multipart conditional statements that depend on the object's state. This state is ususally represented by one or more enumearted constants. Often, several operations will contain this same conditional structure. The state pattern puts each brach of a condition in a seperate class. This lets you treat the object's state as an object in its own right that can very independently from other objects

- ## Benefits:
  - new states can easily be added by defining new subclasses
  - state objects protect the context class from inconsistent internal states
  - makes state transitions more explicit
  
- ## Structure:
  ![class diagramm](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/State_Design_Pattern_UML_Class_Diagram.svg/400px-State_Design_Pattern_UML_Class_Diagram.svg.png)
  
- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/State/state_example.dart)

  ```
  void main(List<String> args) {
    StockDealer dealer = StockDealer();
    dealer.buy();
    dealer.selectStock();
    dealer.sell();
    dealer.selectAmount();
    dealer.buy();
  }

  class StockDealer{
    TradeState _state = InitialState();

    void buy(){
      _state.buy();
    }

    void sell(){
      _state.sell();
    }

    void selectStock(){
      _state = StockChosen();
    }

    void selectAmount(){
      _state = AmountSelected();
    }
  }

  abstract class TradeState{
    void buy();
    void sell();
  }

  class InitialState implements TradeState{
    @override
    void buy() {
      print("Select the stock you want to buy first!");
    }

    @override
    void sell() {
      print("Select the stock you want to sell first!");
    }

  }

  class StockChosen implements TradeState{
    @override
    void buy() {
      print("Enter the amount of stock you want to buy first!");
    }

    @override
    void sell() {
      print("Enter the amount of stock you want to sell first!");
    }
  }

  class AmountSelected implements TradeState{
    @override
    void buy() {
      print("The trade was successfull");
    }

    @override
    void sell() {
      print("The trade was successfull");
    }
  }
  ```