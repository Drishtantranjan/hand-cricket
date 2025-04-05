import 'dart:math';

class GameRepository {
  final Random _random = Random();

  int generateBotChoice() => _random.nextInt(6) + 1;

  bool isOut(int userChoice, int botChoice) => userChoice == botChoice;
}
