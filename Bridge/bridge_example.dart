void main(List<String> args) {
  WordPrinterImplementation german = GermanWordPrinter();
  WordPrinterImplementation english = EnglishWordPrinter();
  SingleWordPrinter singleWordPrinter = SingleWordPrinter(german);
  MultipleWordPrinter multipleWordPrinter = MultipleWordPrinter(english);
  singleWordPrinter.printWord();
  print("--------------");
  multipleWordPrinter.printWords();
}

abstract class WordPrinter {
  WordPrinter(this.implementation);
  WordPrinterImplementation implementation;
  void printWord() {
    implementation.printWord();
  }
}

class SingleWordPrinter extends WordPrinter {
  SingleWordPrinter(WordPrinterImplementation implementation)
      : super(implementation);
}

class MultipleWordPrinter extends WordPrinter {
  MultipleWordPrinter(WordPrinterImplementation implementation)
      : super(implementation);

  void printWords() {
    for (int i = 0; i < 10; i++) {
      printWord();
    }
  }
}

abstract class WordPrinterImplementation {
  void printWord();
}

class GermanWordPrinter implements WordPrinterImplementation {
  @override
  void printWord() {
    print("Hallo");
  }
}

class EnglishWordPrinter implements WordPrinterImplementation {
  @override
  void printWord() {
    print("Hello");
  }
}
