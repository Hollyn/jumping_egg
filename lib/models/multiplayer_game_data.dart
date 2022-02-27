class MultiplayerGameData {
  bool? gameStart;
  int? hostScore;
  int? guestScore;
  bool? guestDied;
  bool? hostDied;
  bool? gameOver;
  bool? guestConnected;
  bool? hostConnected;

  MultiplayerGameData({
    this.gameStart,
    this.hostScore,
    this.guestScore,
    this.guestDied,
    this.hostDied,
    this.gameOver,
    this.guestConnected,
  }) {
    init();
  }

  void fromJson(Map<String, dynamic> json) {
    gameStart = json['game_start'] as bool;
    guestConnected = json['guest_connected'] as bool;
    hostConnected = json['host_connected'] as bool;
    hostScore = json['host_score'] as int;
    guestScore = json['guest_score'] as int;
    guestDied = json['guest_died'] as bool;
    hostDied = json['host_died'] as bool;
    gameOver = json['game_over'] as bool;
  }

  // MultiplayerGameData.fromJson(Map<String, dynamic> json) {
  //   gameStart = json['game_start'] as bool;
  //   guestConnected = json['guest_connected'] as bool;
  //   hostConnected = json['host_connected'] as bool;
  //   hostScore = json['host_score'] as int;
  //   guestScore = json['guest_score'] as int;
  //   guestDied = json['guest_died'] as bool;
  //   hostDied = json['host_died'] as bool;
  //   gameOver = json['game_over'] as bool;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_start'] = gameStart;
    data['guest_connected'] = guestConnected;
    data['host_connected'] = hostConnected;
    data['host_score'] = hostScore;
    data['guest_score'] = guestScore;
    data['guest_died'] = guestDied;
    data['host_died'] = hostDied;
    data['game_over'] = gameOver;
    return data;
  }

  void init() {
    gameStart = false;
    hostScore = 0;
    guestScore = 0;
    guestDied = false;
    hostDied = false;
    gameOver = false;
    guestConnected = false;
    hostConnected = false;
  }
}
