# Builder

- ## Intent:
  Specify the kinds of objects to create using a prototypical instance and create new instances by copying this prototype.

- ## How it works:
  The product interface needs to conatain the clone() method. Any concrete product implementing the product interface then has to define the clone() method. During runtime the client creates one instane of the concrete product and from then on clones this instance using the clone() method to create new objects.
  

- ## Use when:
  - a system should be independent of how its products are created, composed and represented
  - to avoid building a class hierarchy of factorys that parallels the class hierarchy of products
  - an instance of a class can have one of only a few different combinations of state

- ## Prototype manager:
  When the number of prototypes in a system is not fixed you can use a prototype manager that lets the client register and retrieve prototypes by key. This way clients can browse through the available prototypes during runtime.

- ## Structure:
  ![class diagram](https://namnguyen.design/static/25420b818a234c73551042056483b7e1/81523/prototypediagram.png)

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Prototype/prototype_example.dart)

      void main(List<String> args) {
        //create the prototypical instances that should be
        //cloned when creating new instances
        Enemy strongEnemyPrototype = StrongEnemy(
          hp: 1000,
          attackMessage: "I'm strong",
          deathMessage: "Not done yet",
        );
        Enemy weakEnemyPrototype = WeakEnemy(
          hp: 200,
          attackMessage: "I'm weak",
          deathMessage: "Sad life",
        );

        //create new instances by cloning prototypes
        Enemy strongEnemy = strongEnemyPrototype.makeCopy();
        Enemy weakEnemy = weakEnemyPrototype.makeCopy();
        print(strongEnemy.hp);
        print(weakEnemy.hp);
      }

      abstract class Enemy {
        int hp;
        String attackMessage;
        String deathMessage;

        Enemy({
          required this.hp,
          required this.attackMessage,
          required this.deathMessage,
        });

        Enemy makeCopy();
      }

      class StrongEnemy extends Enemy {
        StrongEnemy({
          required int hp,
          required String attackMessage,
          required String deathMessage,
        }) : super(
                hp: hp,
                attackMessage: attackMessage,
                deathMessage: deathMessage,
              );

        @override
        Enemy makeCopy() {
          return StrongEnemy(
              hp: hp, attackMessage: attackMessage, deathMessage: deathMessage);
        }
      }

      class WeakEnemy extends Enemy {
        WeakEnemy({
          required int hp,
          required String attackMessage,
          required String deathMessage,
        }) : super(
                hp: hp,
                attackMessage: attackMessage,
                deathMessage: deathMessage,
              );

        @override
        Enemy makeCopy() {
          return WeakEnemy(
            hp: hp,
            attackMessage: attackMessage,
            deathMessage: deathMessage,
          );
        }
      }
