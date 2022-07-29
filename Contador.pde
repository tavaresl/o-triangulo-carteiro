class Contador extends Entity {
  final float TEMPO_MAXIMO_DE_JOGO = 60f;
  Player player;
  PacoteSpawner pacoteSpawner;
  float tempoDeJogo = 0f;
  
  @Override
  void update(float deltaTime) {
    if (player == null) {
      player = (Player) entidades.stream().filter(e -> e instanceof Player).findFirst().orElse(null);
    }
    
    if (pacoteSpawner == null) {
      pacoteSpawner = (PacoteSpawner) entidades.stream().filter(e -> e instanceof PacoteSpawner).findFirst().orElse(null);
    }

    if (gameState == GameState.GAMEPLAY) {
      
      AABB cameraAABB = camera.getBoundingBox();
      transform.position.x = cameraAABB.topLeftPosition.x + 50;
      transform.position.y = cameraAABB.topLeftPosition.y + 50;
      
      tempoDeJogo += deltaTime;
    
      if (tempoDeJogo < TEMPO_MAXIMO_DE_JOGO) {
        return;
      }
    
      gameState = GameState.GAME_OVER;
      tempoDeJogo = 0f;
      this.destroy();
      
      for (Entity entity : entidades) {
        if (entity instanceof Pacote) {
          entity.destroy();
        }
      }
      
      new MenuGameOver().create();
    }
  }
  
  @Override
  void render() {
    int tempoProxPacote = (int) Math.ceil(pacoteSpawner.INTERVALO_DE_SPAWN - pacoteSpawner.tempoDoUltimoSpawn);
    int tempoRestanteDeJogo = (int) Math.ceil(TEMPO_MAXIMO_DE_JOGO - tempoDeJogo);

    
    if (gameState == GameState.GAMEPLAY) {
      fill(255);
      textSize(24);
      textAlign(LEFT);

      text("Pacotes em posse: " + player.pacotesColetados + "/3", 0, 0);
      text("Pacotes entregues: " + player.pacotesEntregues, 0, 36);
      text("Próximo pacote em: " + tempoProxPacote + "s", 0, 72);
      
      textAlign(RIGHT);
      if (tempoRestanteDeJogo <= 10) {
        fill(255, 0, 0);
      }
      text("Tempo restante: " + tempoRestanteDeJogo, width - 100, 0);
    }
  }
}
