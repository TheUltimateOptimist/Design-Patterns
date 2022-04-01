import 'dart:async';

void main(List<String> args) {
  Wallet myWallet = Wallet();
  myWallet.printCurrentValue();
  TransactionScheduler scheduler = TransactionScheduler();
  scheduler.outstandingTransactions.add(
    BuyStock(
      wallet: myWallet,
      stockToBuy: Stock(
        name: "amazon",
        price: 1000,
      ),
      executionDate: DateTime.now().add(
        Duration(
          seconds: 5,
        ),
      ),
    ),
  );

  Future.delayed(
    Duration(seconds: 7),
    () => myWallet.printCurrentValue(),
  );

  scheduler.outstandingTransactions.add(
    SellStock(
      wallet: myWallet,
      stockToSell: Stock(
        name: "amazon",
        price: 1000,
      ),
      executionDate: DateTime.now().add(
        Duration(
          seconds: 10,
        ),
      ),
    ),
  );

  Future.delayed(
    Duration(seconds: 12),
    (){
      myWallet.printCurrentValue();
      print("Undoing last command");
      scheduler.undoLastTransaction();
      myWallet.printCurrentValue();
    },
  );
}

//Receiver
class Wallet {
  List<Stock> stocks = [];

  void buyStock(Stock stock) {
    stocks.add(stock);
  }

  void sellStock(Stock stock) {
    stocks.removeWhere((element) => element.name == stock.name);
  }

  void printCurrentValue() {
    double value = 0;
    for (var stock in stocks) {
      value += stock.price;
    }
    print("Wallet is worth $value \$");
  }
}

class Stock {
  Stock({required this.name, required this.price});

  final String name;
  final double price;
}

//Invoker
class TransactionScheduler {
  List<Transaction> outstandingTransactions = [];
  List<Transaction> completedTransactions = [];
  TransactionScheduler() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        for (int i = 0; i < outstandingTransactions.length; i++) {
          if (outstandingTransactions[i].getExecutionDate().isBefore(
                DateTime.now(),
              )) {
            outstandingTransactions[i].execute();
            completedTransactions.add(outstandingTransactions[i]);
            outstandingTransactions.removeAt(i);
          }
        }
      },
    );
  }

  void undoLastTransaction() {
    if (completedTransactions.length == 0) {
      throw Exception("No transactions have been made so far!");
    }
    completedTransactions.last.unexecute();
  }
}

enum Status { executed, waiting }

abstract class Transaction {
  Transaction(this.status);
  Status status;
  void execute();
  void unexecute();
  DateTime getExecutionDate();
}

class BuyStock extends Transaction {
  BuyStock(
      {required this.wallet,
      required this.stockToBuy,
      required this.executionDate})
      : super(Status.waiting);

  final Wallet wallet;
  final Stock stockToBuy;
  final DateTime executionDate;

  @override
  void execute() {
    wallet.buyStock(stockToBuy);
  }

  @override
  DateTime getExecutionDate() {
    return executionDate;
  }

  @override
  void unexecute() {
    wallet.sellStock(stockToBuy);
  }
}

class SellStock extends Transaction {
  SellStock(
      {required this.wallet,
      required this.stockToSell,
      required this.executionDate})
      : super(Status.waiting);

  final Wallet wallet;
  final Stock stockToSell;
  final DateTime executionDate;

  @override
  void execute() {
    wallet.sellStock(stockToSell);
  }

  @override
  DateTime getExecutionDate() {
    return executionDate;
  }

  @override
  void unexecute() {
    wallet.buyStock(stockToSell);
  }
}
