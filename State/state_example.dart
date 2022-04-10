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