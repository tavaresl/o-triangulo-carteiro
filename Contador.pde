class Contador extends Entity {
  Player player;
  
  @Override
  void update(float deltaTime) {
    if (player == null) {
      player = (Player) entidades.stream().filter(e -> e instanceof Player).findFirst().orElse(null);
    }
    
    AABB cameraAABB = camera.getBoundingBox();
    transform.position.x = cameraAABB.topLeftPosition.x + 50;
    transform.position.y = cameraAABB.topLeftPosition.y + 50;
  }
  
  @Override
  void render() {
    fill(255);
    textSize(24);
    text("Pacotes em posse: " + player.pacotesColetados + "/3", 0, 0);
  }
}
