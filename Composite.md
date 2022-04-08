# Composite

- ## Intent:
  Compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.

- ## How it works:
  An abstract Component class declares the interface for objects in the composition. Added to that it implements default behaviour for the interface common to all classes when appropriate. Moreover it declares an interface for accessing and managing its child components. Optionally, it also defines an interface for accessing a component's parent in the recursive structure, and implement it if that is appropriate. As many Leaf classes as necessary extend the Component class defining the behaviour of primitive objects in the composition. As many Composite classes as necessary extend the Component class defining the behaviour for components having children. It also stores child components and implements child-related operations from the Component interface. Lastly the client manipulates objects in the composition only through the Component interface.

- ## Use when:
  - you want to represent part-whole hierarchies of objects
  - you want clients to be able to ignore the differenct between compositions of objects and individual objects.

- ## Sidenote:
  Flutter is a perfect example for the Composite pattern. The phrase "Everything is a widget" that you often hear by the developers of that framework is a very clear indication of the Composite pattern being applied.

- ## Structure:
  ![class diagram](https://www.bogotobogo.com/DesignPatterns/images/composite/composite_diagram.gif)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Decorator/decorator_example.dart)
  ```
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
  ```