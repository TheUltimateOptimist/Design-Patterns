# Observer

## Intent:
Define a one to many relationship between objects so that when one object changes state, all its dependents are notified and updated automtically

## How it works:
Any concret subject that needs to share its state across multiple observers implments the subject interface which contains the register, unregister, and notify method. Additionally it maintains a list with all registered observers. All concrete Observers implement the observer interface which contains the update method. All concrete observers also maintain a reference to the concrete subject. When the concrete subject's state changes it will notify all its observers by traversing through its list of registered observers and calling the update Method upon them. Inside the update Method of all concrete Observers the concrete observer's state will then be synced with the concrete subject's state. All observers can easily grab the concrete subject's state, because they all maintain a reference to the concrete subject.

## Use when:
- an abstraction has tow aspects, one dependent on the other, and encapsulating these aspects in seperate objects lets you vary and reuse them independently
- a change to one object requires changing other objects and you do not know how many
- one object should be able to notifiy other objects without knowing who exactly they are

## Consequences:
- Subjects and Observers are decoupled
- the notification a subject sends does not need to specify any kind of receiver
- Observers can be blind to the cost of changing the subject, because they do not know of each other

## Example Code:
    void main(List<String> args) {
      StockMarket stockMarket = StockMarket();
      AmazonStock amazon = AmazonStock(stockMarket);
      AppleStock apple = AppleStock(stockMarket);
      stockMarket.register(amazon);
      stockMarket.register(apple);
      amazon.printPrice();
      apple.printPrice();
      stockMarket.stockPrices = {"amazon": 45, "apple": 56.3};
      amazon.printPrice();
      apple.printPrice();

    }

    abstract class Observer{
      void update();
    }

    abstract class Subject{
      void register(Observer o);
      void unregister(Observer o);
      void notifiyObservers();
    }

    class StockMarket implements Subject{
      List<Observer> observers = List.empty(growable: true);
      Map<String, double> _stockPrices = {"amazon":5, "apple": 6};

      @override
      void notifiyObservers() {
        for(Observer observer in observers){
          observer.update();
        }
      }

      @override
      void register(Observer o) {
        observers.add(o);
      }

      @override
      void unregister(Observer o) {
        observers.removeWhere((Observer observer) => observer == o);
      }

      void set stockPrices(Map<String, double> newPrices){
        _stockPrices = newPrices;
        print("Stock prices changed!");
        notifiyObservers();
      }

      Map<String, double> get stockPrices{
        return _stockPrices;
      }
    }

    class AmazonStock implements Observer{
      late final StockMarket _stockMarket;
      late double stockPrice;

      AmazonStock(StockMarket stockMarket){
        _stockMarket = stockMarket;
        stockPrice = _stockMarket.stockPrices["amazon"] ?? 0;
      }

      @override
      void update() {
        stockPrice = _stockMarket.stockPrices["amazon"] ?? 0;
      }

      void printPrice(){
        print("Amazon: " + stockPrice.toString() + " Euro");
      }
    }

    class AppleStock implements Observer{
      late final StockMarket _stockMarket;
      late double stockPrice;

      AppleStock(StockMarket stockMarket){
        _stockMarket = stockMarket;
        stockPrice = stockMarket.stockPrices["apple"] ?? 0;
      }

      @override
      void update() {
        stockPrice = _stockMarket.stockPrices["apple"] ?? 0;
      }

      void printPrice(){
        print("Apple: " + stockPrice.toString() + " Euro");
      }
    }