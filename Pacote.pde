class Pacote extends Entity {
  float velocidadeDeRotacao = PI;
  float intervaloDePulso = 2f;
  float duracaoDoPulso = 2f;
  float size = 25;
  int quantidadeDePulsos = 3;

  @Override
  AABB getBoundingBox() {
    return new AABB(
      new PVector(transform.position.x - (size * sqrt(2)) / 2, transform.position.y - (size * sqrt(2)) / 2),
      new PVector(transform.position.x + (size * sqrt(2)) / 2, transform.position.y - (size * sqrt(2)) / 2),
      new PVector(transform.position.x + (size * sqrt(2)) / 2, transform.position.y + (size * sqrt(2)) / 2),
      new PVector(transform.position.x - (size * sqrt(2)) / 2, transform.position.y + (size * sqrt(2)) / 2)
      );
  }

  @Override
  void update(float deltaTime) {
    usaColisor = true;
    transform.rotation += deltaTime * velocidadeDeRotacao;
  }

  @Override
  void render() {
    noStroke();
    fill(0, 255, 255);
    rectMode(CENTER);
    rect(0, 0, size, size);
  }
}
