abstract class GameEvent {}

class StartGameEvent extends GameEvent {}

class UserPlayedEvent extends GameEvent {
  final int userChoice;
  UserPlayedEvent(this.userChoice);
}
