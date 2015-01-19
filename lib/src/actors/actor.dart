part of hello_dart;

const int directionRight = 0;
const int directionDown = 90;
const int directionLeft = 180;
const int directionUp = 270;

/// Superclass for all [Actor]s.
abstract class Actor {

  /// A reference to the world.
  World world;

  /// The horizontal position.
  int x = 0;

  /// The vertical position.
  int y = 0;

  /// The direction of this actor in degrees.
  int direction = directionRight;

  String get directionName {
    switch (direction) {
      case directionDown:
        return 'down';
      case directionLeft:
        return 'left';
      case directionUp:
        return 'up';
      default:
        return 'right';
    }
  }

  /// The direction of this actor in radian.
  num get directionRadian => _degreesToRadian(direction);


  /// The layer of the stage that this actor is added to.
  Sprite get layer => world._getLayer(this);

  /// Visual representation of this actor.
  ///
  /// Note: The position and direction of the actor and its bitmap may
  /// not be in sync because the visual moves and turns are delayed.
  Bitmap _bitmap;

  /// Constructor.
  Actor([this.world, this.x, this.y]);

  /// Returns this actor's current image.
  BitmapData get image;

  /// Moves the actor in the specified [direction].
  ///
  /// If the actor moves over the world's edge it will appear on the opposite
  /// side.
  void _move(int direction) {
    switch (direction) {
      case directionRight:
        x = (x + 1) % world.widthInCells;
        break;
      case directionDown:
        y = (y + 1) % world.heightInCells;
        break;
      case directionLeft:
        x = (x - 1) % world.widthInCells;
        break;
      case directionUp:
        y = (y - 1) % world.heightInCells;
        break;
    }
  }

  /// Adds the bitmap of this actor to the world.
  void _bitmapAddToWorld() {
    if (_bitmap == null) {
      // Create the bitmap.
      var coords = World.cellToPixel(x, y);
      _bitmap = new Bitmap(image);
      _bitmap
          ..x = coords.x
          ..y = coords.y;
    }

    // Add to the layer for this actor type.
    _bitmap.addTo(layer);
  }

  /// Removes the bitmap of this actor from the world.
  void _bitmapRemoveFromWorld() {
    if (_bitmap != null) {
      _bitmap.removeFromParent();
    }
  }

  /// Creates a move animation to the [targetPoint] with the specified
  /// [duration] in seconds.
  Animatable _bitmapMoveAnimation(Point startPoint, Point targetPoint,
                                  String directionName, double duration) {
    Point targetPixel = World.cellToPixel(targetPoint.x, targetPoint.y);

    return new Tween(_bitmap, duration,
        TransitionFunction.linear)
      ..animate.x.to(targetPixel.x)
      ..animate.y.to(targetPixel.y);
  }

  /// Creates a turn animation from [startDirectionName] to [endDirectionName]
  /// with the specified [duration] in seconds.
  ///
  /// If the bitmap was turned counterclockwise, set the [clockwise] parameter
  /// to false.
  ///
  /// Note: Unless a subclass overrides this method, no turning will be done.
  Animatable _bitmapTurnAnimation(String startDirectionName, String endDirectionName,
                                  double duration, {clockwise: true}) {
    // Do nothing.
    return new DelayedCall(() {}, 0);
  }

  /// Creates a [DelayedCall] to update the image to [newImage].
  Animatable _bitmapUpdateImage(BitmapData newImage, double duration) {
    return new DelayedCall(() {
      _bitmap.bitmapData = newImage;
    }, 0);
  }
}

/// Helper method to convert the [degrees] to radian.
num _degreesToRadian(num degrees) => degrees * math.PI / 180;