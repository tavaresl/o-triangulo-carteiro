class PacoteSpawner extends Entity {
  final float INTERVALO_DE_SPAWN = 5f;
  float tempoDoUltimoSpawn = Float.POSITIVE_INFINITY;
  
  @Override
  void update(float deltaTime) {
    tempoDoUltimoSpawn += deltaTime;
    
    if (gameState != GameState.GAMEPLAY) return;
    
    if (tempoDoUltimoSpawn >= INTERVALO_DE_SPAWN) {
      tempoDoUltimoSpawn = 0f;
      spawn();
    }
  }
  
  void spawn() {
    Pacote pacote = new Pacote();
    pacote.transform.position.x = random(0, worldWidth);
    pacote.transform.position.y = random(0, worldHeight);
    pacote.create();
  }
}
