void main(List<String> args) {
  //if client wants to print hello world he only needs to know the printer class
  //he does not need to deal with the subsystem classes HelloPrinter and WorldPrinter
  Printer().printHelloWorld();
}

class Printer{
  printHelloWorld(){
    HelloPrinter().printHello();
    WorlPrinter().printWorld();
  }
}

class HelloPrinter{
  void printHello(){
    print("Hello");
  }
}

class WorlPrinter{
  void printWorld(){
  print("World");
  }
}