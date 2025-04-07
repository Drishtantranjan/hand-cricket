class HandCricketGame {
  List<int> userRuns;
  List<int> botRuns;
  bool isUserBatting;
  bool isGameOver;
  String winner;

  // 👇 New field added
  int? currentBotNumber;

  HandCricketGame({
    required this.userRuns,
    required this.botRuns,
    required this.isUserBatting,
    required this.isGameOver,
    required this.winner,
    this.currentBotNumber,
  });

  // 👇 You might also need a copyWith if you're using immutability:
  HandCricketGame copyWith({
    List<int>? userRuns,
    List<int>? botRuns,
    bool? isUserBatting,
    bool? isGameOver,
    String? winner,
    int? currentBotNumber,
  }) {
    return HandCricketGame(
      userRuns: userRuns ?? this.userRuns,
      botRuns: botRuns ?? this.botRuns,
      isUserBatting: isUserBatting ?? this.isUserBatting,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
      currentBotNumber: currentBotNumber ?? this.currentBotNumber,
    );
  }
}
