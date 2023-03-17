import 'package:hello_dart/hello_dart.dart';

/// Your player.
class MyPlayer extends Player {

  /// Your program.
  start() {
    while (!onStar()) {
      while (canMove() && !onStar())
        move();
      if (!treeLeft())
        turnLeft();
      else
        turnRight();
    }
    removeStar();
  }
}


main() {
  createWorld('scenario-c.txt', MyPlayer());
}
