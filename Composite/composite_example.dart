void main(List<String> args) {
  Component fileSystem = Folder(
    "root",
    [
      Folder(
        "Sisters",
        [
          File("Lisa.txt"),
          File("Odillia.txt"),
        ],
      ),
      Folder(
        "Parents",
        [
          File("Peter.txt"),
          File("Lydia.txt"),
        ],
      ),
    ],
  );
  fileSystem.printMe();
}

abstract class Component {
  void printMe();
  void add(Component component) {
    throw UnimplementedError();
  }

  void remove(Component component) {
    throw UnimplementedError();
  }

  Component getChild(int index) {
    throw UnimplementedError();
  }
}

class File extends Component {
  File(this.fileName);

  final String fileName;

  @override
  void printMe() {
    print("File: $fileName");
  }
}

class Folder extends Component {
  Folder(this.folderName, this.children);

  final String folderName;

  List<Component> children;

  @override
  void printMe() {
    print("Folder: $folderName");
    for (Component child in children) {
      child.printMe();
    }
  }

  @override
  void add(Component component) {
    children.add(component);
  }

  @override
  void remove(Component component) {
    children.remove(component);
  }

  @override
  Component getChild(int index) {
    return children[index];
  }
}
