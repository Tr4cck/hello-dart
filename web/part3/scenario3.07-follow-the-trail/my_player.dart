import 'package:hello_dart/hello_dart.dart';

/// Your player.
class MyPlayer extends Player {

  /// Your program.
  start() {
    while (!treeFront()) {
      while (starFront()) {
        move();
      }
      if (starLeft()) {
        turnLeft();
      } else if (starRight()) {
        turnRight();
      }
    }
  }
}


main() {
  createWorld('scenario-b.txt', MyPlayer());
}
