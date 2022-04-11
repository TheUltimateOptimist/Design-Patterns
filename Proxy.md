# Builder

- ## Intent:
  Provide a surrogate or placeholder for another object to control access to it.

- ## How it works:
  Create a Proxy class that maintains a reference letting the proxy access the real subject. The proxy also needs to provide an interface identical to Subject's so that a proxy can be substituated for the real subject. This proxy class is responsible for controling the access to the real subject and creating or deleting it. Other resposibilities are possible depending on the kind of proxie.
  Next you need an abstract subject class that defines a common interface for RealSubject and Proxy so that a Proxy can be used anywhere a RealSubject is expected. Lastly you need to create a RealSubject class that defines the real object the proxy represents.
  
- ## Types of proxies:
  - ### remote proxie
    A remote proxie is responsible for representing an object located remotely
  - ### virtual proxie
    A virtual proxie creates expensive objects on demand
  - ### protection proxie
    A protection proxie controls access to the original object. Protection Proxies are useful when objects should have different access rights.
  - ### smart reference
    A smart reference is a replacement for a bare pointer that performs additional actions when an object is accessed.

- ## Structure:
  ![class diagram](https://miro.medium.com/max/974/1*Zs_rYXaZmAGsm0PaikCbZw.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Proxy/proxy_example.dart)

    ```
    void main(List<String> args) {
    //creates the proxy, human object will be created later
    Creature human = HumanProxie();
    
    //now human object will be created(at first access)
    human.increaseAge();
    }

    abstract class Creature<T> {
    void increaseAge();
    void changeName(String newName);
    }

    class Human implements Creature {
    Human(this._name, this._age);

    String _name;

    int _age;

    @override
    void changeName(String newName) {
        _name = newName;
    }

    @override
    void increaseAge() {
        _age++;
    }
    }

    class HumanProxie implements Creature {
    Human? human;

    @override
    void changeName(String newName) {
        if(human == null){
        human = Human("Fritz Heinz", 30);
        }
        human!.changeName(newName);
    }

    @override
    void increaseAge() {
        if(human == null){
        human = Human("Fritz Heinz", 30);
        }
        human!.increaseAge();
    }
    }
    ```