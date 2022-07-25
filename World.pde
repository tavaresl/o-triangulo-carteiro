class World extends Entity {
  @Override
  void update(float deltaTime) {
    transform.position.x = -(camera.transform.position.x - width / 2);
    transform.position.y = -(camera.transform.position.y - height / 2);
  }
  
  @Override
  void render() {
    pushStyle();
      noStroke();
      fill(50,50,50);
      rect(0, 0, worldWidth, worldHeight);
      
      noFill();
      stroke(80);
      int numColunas = worldWidth / 120;
      int numLinhas = worldHeight / 120;
      
      for (int i = 1; i < numLinhas; i++) {
        line(0, i * 120, worldWidth, i * 120);
      }
      
      for (int i = 1; i < numColunas; i++) {
        line(i * 120, 0, i * 120, worldHeight);
      }
    popStyle();
  }
}
