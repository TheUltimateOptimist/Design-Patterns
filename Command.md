# Command

- ## Intent:
  Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations

- ## How it works:
  Create an Invoker class that stores commands and calls there execute Methods. Create an abstract command class that exposes the execute method to its implementers. Create as many ConcreteCommand classes as you like that implement the command interface overriding the execute method. Lastly create a receiver class that defines the concrete actions. This receiver class has to be given to a ConcreteCommand when it is instantiated as it is used in all ConcreteCommand's execute methods to execute the correct action. The client can then instantiate a ConcreteCommand with a Receiver instance and  add this concrete command to the an invoker object. Depending on the invoker's logic it will execute the concrete command at any time.

- ## Use when you want to:
  - parametrize Objects by an action to perform
  - specify, queue, and execute requests at different times
  - support undo
  - support logging changes so that they can be reapplied in case of a system crash
  - structure a system around high-level operations built on primitive operations

- ## Structure:
  ![class diagram](https://miro.medium.com/max/1400/0*whyKeG0cDMnC6thc.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Command/command_example.dart)

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

