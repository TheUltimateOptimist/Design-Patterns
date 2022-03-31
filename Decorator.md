# Decorator

- ## Intent:
  Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

- ## How it works:
  Create an abstract component class that defines the operations that can be executed on the components. Then define as many ConcreteComponent classes that extend or implement the Component class overriding the operations it defines. Next define an abstract Decorator class that also implements/extends the Component class. This Decorator class keeps a reference to the Component class its decoration belongs to. It uses this reference to delegate all operations to the proper component. Lastly all ConcreteDecorator classes extend the Decorator class. Inside the ConcreteDecorator classes added functionality or state can be added. 

- ## Use when:
  - you want to add responsibilities to individual objects dynamically and transparently without affecting other objects
  - for responsibilities that can be withdrawn
  - extension by subclassing is impractical

- ## Sidenote:
  The flutter framework makes heavy use of the Decorator pattern. For example when you wrap a widget with Positioned widget to set its position in the given constraints.

- ## Example Code:
  [View on Github](https://github.com/TheUltimateOptimist/Design-Patterns/blob/master/Decorator/decorator_example.dart)

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