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
