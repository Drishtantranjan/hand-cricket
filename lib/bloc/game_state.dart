import 'package:hand_cricket/model/hand_cricket_model.dart';

abstract class GameState {
  final HandCricketGame game;

  GameState(this.game);
}

class GameInitialState extends GameState {
  GameInitialState() : super(HandCricketGame());
}

class GameUpdatedState extends GameState {
  GameUpdatedState(HandCricketGame game) : super(game);
}
