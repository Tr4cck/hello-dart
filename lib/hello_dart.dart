library hello_dart;

import 'dart:html' as html;
import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:stagexl/stagexl.dart';
import 'package:string_scanner/string_scanner.dart';

part 'src/actors/actor.dart';
part 'src/actors/box.dart';
part 'src/actors/player.dart';
part 'src/actors/star.dart';
part 'src/actors/tree.dart';

part 'src/world/world.dart';
part 'src/world/scenario.dart';
part 'src/world/field.dart';
part 'src/world/exceptions.dart';

part 'translations/messages.dart';
part 'translations/messages_de.dart';

/// The character of the player.
///
/// Possible characters:
/// * boy
/// * catgirl
/// * stargirl
/// * pinkgirl
String character = 'boy';

/// The background fields.
///
/// Possible fields:
/// * grass
/// * stone
/// * wood
/// * dirt
String background = 'grass';

/// The translated messages.
///
/// For other languages, set this variable to another [Messages] object.
/// Example for German:
///     messages = new MessagesDe();
Messages messages = new Messages();

/// Initializes the world with the specified [scenarioFile] and shows it.
///
/// The [player] is the instance where the behaviour is programmed in.
///
/// The [speed] is the duration between the execution of actions in milliseconds.
void launch(String scenarioFile, Player player, [int speed = 300]) {

  World world = new World(player, new Duration(milliseconds: speed));

  // Initialize the world.
  world.init(scenarioFile).catchError((e) {
    // Show an alert if it is a HelloDartException.
    html.window.alert(e.toString());
  }, test: (e) => e is HelloDartException);
}