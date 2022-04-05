# Singleton

- ## Intent:
  Ensure a class has ony one instance and a global point of access to it. 

- ## How to implement:
  First create the Singleton class. Give it a private constructor. Using the private Constructor create a class instance and store it as a private static final variable inside the class. Lastly define the factory constructor simply returning the variable that holds the instance.

- ## Use when:
  - there must be exactly one instance of a class and it must be accessible to clients from a well known access point
  - when the sole instance should be extensible by subclassing, and clients should be able to use an extended instance without modifying their code

- ## Structure:
  ![class diagram](https://miro.medium.com/max/1400/0*sO27CKj4z6e4stiN.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Factory/factory_example.dart)

      void main(List<String> args) {
        UserSettings settings = UserSettings();
        settings.isLightMode = false;
        UserSettings settingsTwo = UserSettings();
        print(settings.hashCode);
        print(settingsTwo.hashCode);
        //both hashcodes printed will be identical
      }

      class UserSettings{

        bool isLightMode = true;

        UserSettings._privateConstructor();

        static final _instance = UserSettings._privateConstructor();

        factory UserSettings() => _instance;
      }