class Player extends Entity {
  private final int MAXIMO_DE_PACOTES = 3;
  PVector direcao = new PVector();
  PVector velocidade = new PVector();
  PVector aceleracao = new PVector();
  float variacaoDirecaoMax = QUARTER_PI;
  float velocidadeMax = 500;
  float size = 40;
  int pacotesColetados = 0;
  int pacotesEntregues = 0;
  
  boolean estaLotado() {
    return pacotesColetados == MAXIMO_DE_PACOTES;
  }
  
  @Override
  AABB getBoundingBox() {
    return new AABB(
      new PVector(transform.position.x - size / 2, transform.position.y - size / 2),
      new PVector(transform.position.x + size / 2, transform.position.y - size / 2),
      new PVector(transform.position.x + size / 2, transform.position.y + size / 2),
      new PVector(transform.position.x - size / 2, transform.position.y + size / 2)
    );
  }
  
  @Override
  void update(float deltaTime) {
    usaColisor = true;
    PVector destino = new PVector();
    
    if (PressedKeys.W) destino.y -= 1;
    if (PressedKeys.A) destino.x -= 1;
    if (PressedKeys.S) destino.y += 1;
    if (PressedKeys.D) destino.x += 1;
    
    destino.setMag(velocidadeMax * deltaTime);
    
    PVector variacaoDirecao = PVector.sub(destino, velocidade);
    variacaoDirecao.limit(variacaoDirecaoMax);
    aceleracao.add(variacaoDirecao);
    velocidade.add(aceleracao);
    transform.position.add(velocidade);
    aceleracao.set(0,0);
    direcao = velocidade.copy().normalize();    
    
    if (velocidade.x != 0 || velocidade.y != 0) transform.rotation = direcao.heading();
    if (transform.position.x <= 0) transform.position.x = 0;
    if (transform.position.y <= 0) transform.position.y = 0;
    if (transform.position.x >= worldWidth) transform.position.x = worldWidth;
    if (transform.position.y >= worldHeight) transform.position.y = worldHeight;
    
    camera.transform.position.x = transform.position.x;
    camera.transform.position.y = transform.position.y;
    
    // Distribui pacotes coletados ao redor do player
    if (children.size() > 0) {
      float anguloEntrePacotes = TWO_PI / children.size();
      
      for (int i = 0; i < children.size(); i++) {
        children.get(i).transform.position = new PVector(50, 0).rotate(anguloEntrePacotes * i + PI);
      }
    }
  }
  
  @Override
  void aoColidirCom(Entity outro) {
    if (outro instanceof Pacote) {
      if (pacotesColetados < 3) {
        pacotesColetados++;
        outro.bindTo(this);
      }
    } else if (outro instanceof ZonaDeDespacho) {
      pacotesEntregues += pacotesColetados;
      pacotesColetados = 0;
      
      for (int i = children.size() - 1; i >= 0; i--) {
        release(children.get(i));
      }
    }
  }
  
  @Override
  void render() {
    noStroke();
    regularPolygon(0, 0, size / 2, 3);
    fill(180, 0, 0);
    regularPolygon(15, 0, size / 8, 3);
  }
}
