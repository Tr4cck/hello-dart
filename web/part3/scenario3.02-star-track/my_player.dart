import 'package:hello_dart/hello_dart.dart';

/// Your player.
class MyPlayer extends Player {

  /// Your program.
  start() {
    while (canMove()) {
      if (!onStar()) {
        putStar();
        move();
      } else {
        move();
      }
    }
    putStar();
  }
}


main() {
  createWorld('scenario.txt', MyPlayer());
}
