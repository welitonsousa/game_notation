enum GameState {
  playing,
  finished,
  paused,
  wishlist,
  platinum;

  String get label {
    return switch (this) {
      playing => 'Jogando',
      finished => 'Zerado',
      platinum => 'Platinado',
      wishlist => 'Lista de Desejos',
      paused => 'Parado',
    };
  }
}
