void main(List<String> args) {
  UIComponent componentOne = Positioned(
    child: Container(
      width: 100,
      height: 100,
    ),
    x: 5,
    y: 5,
  );
  UIComponent componentTwo = Positioned(
    child: Border(
      child: Circle(
        radius: 6,
      ),
      borderWidth: 2.0,
    ),
    x: 2,
    y: 10,
  );
  componentOne.build();
  print("-----------");
  componentTwo.build();
}

abstract class UIComponent {
  void build();
}

class Container implements UIComponent {
  Container({required this.width, required this.height});

  final double width;
  final double height;

  @override
  void build() {
    print("ContainerWidth: $width, ContainerHeight: $height");
  }
}

class Circle implements UIComponent {
  Circle({required this.radius});

  final double radius;

  @override
  void build() {
    print("CircleRadius: $radius");
  }
}

class UIComponentDecoration implements UIComponent {
  UIComponentDecoration({required this.child});

  final UIComponent child;

  @override
  void build() {
    child.build();
  }
}

class Border extends UIComponentDecoration {
  Border({required UIComponent child, required this.borderWidth})
      : super(child: child);

  final double borderWidth;

  @override
  void build() {
    super.build();
    print("BorderWidth: $borderWidth");
  }
}

class Positioned extends UIComponentDecoration {
  Positioned({required UIComponent child, required this.x, required this.y})
      : super(child: child);

  final double x;
  final double y;

  @override
  void build() {
    super.build();
    print("Position: $x, $y");
  }
}
