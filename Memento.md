# Memento

- ## Intent:
  Without violating encapsulation, capture and externalize an object's internal state so that the object can be restored to this state later.

- ## How it works:
  First create a memento class that is responsible for storing an other object's state. It exposes  a ´getState()´ and a ´setState()´ method. The object whose state is stored by the memento needs to expose a `setMemento(Memento m)` method(adapts the object's state to state stored in the given memento) and a ´createMemento()´ method(returns a memento created from the object's state). So the client can then at any time store an originator's state by retrieving a Memento object using the ´createMemento()´ method and restore the same or any originator to that state later using the `setMemento(Memento m)` method. 
  
- ## Use when:
  - a snapshot of(some portion of) an object's state must be saved so that it can be restored to that state later, and
  - a direct interface to obtaining the state would expose implementation details and break the object's encapsualation

- ## Consequences:
  - preserves encapsualtion boundaries. It avoids exposing information that only an originator should manage but that needs to be stored nonetheless
  - simplifies the Originator. Having clients manage the state they ask for simplifies Originator and keeps clients from having to notify originators when they are done
  - it might be expensive. Memento's are inappropriate if Originator must copy larege amounts of information to store in the memento or if clients create and return mementos to the originator very often.
  - The caretaker does not know what state is in the mementos it stores and thus does not know the hidden costs of caring fot them

- ## Structure:
  ![class diagram](data:image/png;base64,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)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Memento/memento_example.dart)

  ```
  void main(List<String> args) {
  TextEditor editor = TextEditor();
  editor.addWord("Hello");
  editor.addSpace();
  editor.addWord("World");
  editor.printText();
  editor.undo();
  editor.printText();
  editor.undo();
  }

  //Memento
  //stores state change of Text class
  class TextState{
    TextState(this.text);

    String text;

    String getState(){
      return text;
    }
  }

  //Originator
  //this objects state change is stored in the TextChange class
  class Text{
    String text = "";

    void setMemento(TextState change){
      text = change.getState();
    }

    TextState createMemento(){
      return TextState(text);
    }

    void addString(String willBeAdd){
      text+=willBeAdd;
    }
  }

  //Caretaker
  //provides undo operation
  class TextEditor{

    TextState? memento;

    Text originator = Text();

    void undo(){
      if(memento is TextState){
        originator.setMemento(memento!);
        memento = null;
      }
      else throw NothingToUndoException();
    }

  void addWord(String word){
    _saveLast();
    originator.addString(word);
  }

  void addSpace(){
    _saveLast();
    originator.addString(" ");
  }

  void printText(){
    print(originator.text);
  }

  void _saveLast(){
    memento = originator.createMemento();
  }
  }

  class NothingToUndoException implements Exception{
    @override
    String toString() {
      return "There is nothing to undo! Either you tried to undo twice in a row or you tried to undo before doing anything";
    }
  }
  ```