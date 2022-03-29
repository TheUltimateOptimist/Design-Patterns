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
