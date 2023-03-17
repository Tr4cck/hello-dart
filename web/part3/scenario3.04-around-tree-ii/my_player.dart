import 'package:hello_dart/hello_dart.dart';

/// Your player.
class MyPlayer extends Player {

  /// Your program.
  start() {
    while (!onStar()) {
      while (!treeFront()) {
        move();
      }
      goAroundTree();
    }
    removeStar();
  }

  goAroundTree() {
    turnLeft();
    move();
    turnRight();
    move();
    move();
    turnRight();
    move();
    turnLeft();
  }
}


main() {
  createWorld('scenario-c.txt', MyPlayer());
}
