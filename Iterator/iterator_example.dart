void main(List<String> args) {
  Iterator<int> oneDimIterator = OneDimList([1,2,3,4,5,6]).createIterator();
  Iterator<int> twoDimIterator = TwoDimList([[1,2,3], [4,5,6]]).createIterator();
  printListElements(oneDimIterator);
  printListElements(twoDimIterator);
}

void printListElements(Iterator iter){
  iter.first();
  while(!iter.isDone()){
    print(iter.currentItem().toString());
    iter.next();
  }
}

abstract class GeneralList<T>{
  //Factory method design pattern
  Iterator<T> createIterator();
  int count();
  void add(T item);
  void remove(T item);
  T get(int index);
}

abstract class Iterator<T>{
  int _current = 0;
  void first();
  void next();
  bool isDone();
  T currentItem();
}

class OneDimList<T> extends GeneralList<T>{
  List<T> content;

  OneDimList(this.content);

  @override
  void add(T item) {
    content.add(item);
  }

  @override
  void remove(T item) {
    content.remove(item);
  }

  @override
  int count() {
    return content.length;
  }

  @override
  Iterator<T> createIterator() {
    return ForwardIterator(this);
  }

  @override
  T get(int index) {
    return content[index];
  }
}

class TwoDimList<T> extends GeneralList<T>{
  List<List<T>> content;

  TwoDimList(this.content);

  @override
  void add(T item) {
    content.add([item]);
  }

  @override
  void remove(T item) {
    for(int i = 0; i < content.length; i++){
      if(content[i].remove(item)){
        break;
      }
    }
  }

  @override
  int count() {
    int count = 0; 
    for(int i = 0; i < content.length; i++){
      count+=content[i].length;
    }
    return count;
  }

  @override
  Iterator<T> createIterator() {
    return BackWardsIterator(this);
  }

  @override
  T get(int index) {
    List<T> oneDimList = List.empty(growable: true);
    for(int i = 0; i < content.length; i++){
      for(int j = 0; j < content[i].length; j++){
        oneDimList.add(content[i][j]);
      }
    }
    return oneDimList[index];
  }
}

class ForwardIterator<T> extends Iterator<T>{
  ForwardIterator(this.list);

  final GeneralList<T> list;

  @override
  T currentItem() {
    return list.get(_current);
  }

  @override
  void first() {
    _current = 0;
  }

  @override
  bool isDone() {
    return _current == list.count();
  }

  @override
  void next() {
    _current++;
  }
}

class BackWardsIterator<T> extends Iterator<T>{
  BackWardsIterator(this.list);

  final GeneralList<T> list;

  @override
  T currentItem() {
    return list.get(_current);
  }

  @override
  void first() {
    _current = list.count() - 1;
  }

  @override
  bool isDone() {
    return _current < 0;
  }

  @override
  void next() {
    _current--;
  }
}

