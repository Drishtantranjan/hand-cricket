class HandCricketGame {
  List<int> userRuns;
  List<int> botRuns;
  bool isUserBatting;
  bool isGameOver;
  String winner;
  int? currentBotNumber;

  HandCricketGame({
    required this.userRuns,
    required this.botRuns,
    required this.isUserBatting,
    required this.isGameOver,
    required this.winner,
    this.currentBotNumber,
  });

  // Method to get the total runs scored by the user
  int get totalUserRuns => userRuns.fold(0, (sum, run) => sum + run);

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
