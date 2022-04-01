import 'dart:async';

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

  //testing stream implementation
  print("testing stream implementation");
  SStockMarket sStockMarket = SStockMarket();
  SAmazonStock sAmazon = SAmazonStock(sStockMarket);
  SAppleStock sApple = SAppleStock(sStockMarket);
  sAmazon.printPrice();
  sApple.printPrice();
  sStockMarket.changeStockPrices({"amazon": 1000, "apple": 500});
  sAmazon.printPrice();
  sApple.printPrice();
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

//
//implemented with stream
//

class SStockMarket extends StreamView<SStockMarket>{  
  SStockMarket._(this._controller) : super(_controller.stream.asBroadcastStream());
  factory SStockMarket() => SStockMarket._(StreamController(sync: true,),);

  final StreamController<SStockMarket> _controller;

  Future<void> close() => _controller.close();

  Map<String, double> _stockPrices = {"amazon":5, "apple": 6};

  void changeStockPrices(Map<String, double> stockPrices) {
    _stockPrices = stockPrices;
    _controller.add(this);
  }

  double getStockPrice(String stockName){
    return _stockPrices[stockName] ?? 0;
  }
}

class SAmazonStock{
  SAmazonStock(SStockMarket stockMarket){
    stockPrice = stockMarket.getStockPrice("amazon");
    subscription = stockMarket.listen((value) {
      stockPrice = value.getStockPrice("amazon");
    });
  }
  late double stockPrice;
  late StreamSubscription<SStockMarket> subscription;

  void printPrice(){
    print("Amazon: $stockPrice Euro");
  }
}

class SAppleStock{
  SAppleStock(SStockMarket stockMarket){
    stockPrice = stockMarket.getStockPrice("apple");
    subscription = stockMarket.listen((value) {
      stockPrice = value.getStockPrice("apple");
    });
  }
  late double stockPrice;
  late StreamSubscription<SStockMarket> subscription;

  void printPrice(){
    print("Apple: $stockPrice Euro");
  }
}
