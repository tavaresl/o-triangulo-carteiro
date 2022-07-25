class Camera extends Entity {
  int viewportWidth;
  int viewportHeight;
  
  Camera(PVector initialPosition, int viewportWidth, int viewportHeight) {
    this.transform.position.x = initialPosition.x;
    this.transform.position.y = initialPosition.y;
    this.viewportWidth = viewportWidth;
    this.viewportHeight = viewportHeight;
  }
  
  @Override
  AABB getBoundingBox() {
    return new AABB(
      new PVector(transform.position.x - viewportWidth / 2, transform.position.y - viewportHeight / 2),
      new PVector(transform.position.x + viewportWidth / 2, transform.position.y - viewportHeight / 2),
      new PVector(transform.position.x + viewportWidth / 2, transform.position.y + viewportHeight / 2),
      new PVector(transform.position.x - viewportWidth / 2, transform.position.y + viewportHeight / 2)
    );
  }
}
