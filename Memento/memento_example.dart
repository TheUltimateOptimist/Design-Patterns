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