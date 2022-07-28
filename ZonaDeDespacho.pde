class ZonaDeDespacho extends Entity {
  final float SIZE = 280;
  final float PULSE_DURATION = .5f;
  final float PULSE_COOLDOWN = .5f;
  float pulseTime = 0f;
  float pulseCooldownTime = 0f;
  
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
    
    if (pulseTime >= PULSE_DURATION && pulseCooldownTime < PULSE_COOLDOWN) {
      pulseCooldownTime += deltaTime;
      
      if (pulseCooldownTime >= PULSE_COOLDOWN) {
        pulseTime = 0f;
        pulseCooldownTime = 0f;
      }
    } else {
      pulseTime += deltaTime;
    }
  }
  
  @Override
  void render() {
    float raio = map(pulseTime, 0, PULSE_DURATION, 0, SIZE);
    float alpha = map(pulseTime, 0, PULSE_DURATION, 255, 0);
    
    noStroke();
    fill(255, 255, 0, alpha);
    circle(0, 0, raio);
  }
}
