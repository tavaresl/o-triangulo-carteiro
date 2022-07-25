class ZonaDeDespacho extends Entity {
  final float SIZE = 280;
  
  @Override
  AABB getBoundingBox() {
    return new AABB(
      new PVector(transform.position.x - SIZE / 4 * sqrt(2), transform.position.y - SIZE / 4 * sqrt(2)),
      new PVector(transform.position.x + SIZE / 4 * sqrt(2), transform.position.y - SIZE / 4 * sqrt(2)),
      new PVector(transform.position.x + SIZE / 4 * sqrt(2), transform.position.y + SIZE / 4 * sqrt(2)),
      new PVector(transform.position.x - SIZE / 4 * sqrt(2), transform.position.y + SIZE / 4 * sqrt(2))
    );
  }
  
  @Override
  void update(float deltaTime) {
    usaColisor = true;
    transform.position.x = worldWidth - SIZE;
    transform.position.y = worldHeight / 2;
  }
  
  @Override
  void render() {
    noFill();
    stroke(127, 127, 0);
    circle(0, 0, SIZE);
  }
}
