void main(List<String> args) {
  Multiplier normal = NormalMultiplier();
  Multiplier zeroM = ZeroMultiplier();
  print("5*5 normal: ${normal.multiplyPositiveNumbers(5,5)}");
  print("5*5 zero: ${zeroM.multiplyPositiveNumbers(5,5)}");
}

abstract class Multiplier{
  int multiplyPositiveNumbers(int a, int b){
    int result = 0;
    for(int i = 0; i < a; i++){
      result = add(result, b);
    }
    return result;
  }

  int add(int a, int b);
}

class NormalMultiplier extends Multiplier{
  @override
  int add(int a, int b) {
    return a + b;
  }
}

class ZeroMultiplier extends Multiplier{
  @override
  int add(int a, int b) {
    return 0;
  }
}