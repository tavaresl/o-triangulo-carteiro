class PacoteSpawner extends Entity {
  float tempoDoUltimoSpawn = Float.POSITIVE_INFINITY;
  float intervaloDeSpawn = 5f;
  
  @Override
  void update(float deltaTime) {
    tempoDoUltimoSpawn += deltaTime;
    
    if (tempoDoUltimoSpawn >= intervaloDeSpawn) {
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
