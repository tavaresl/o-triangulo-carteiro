class GPS extends Entity {
  final float MAIOR_DISTANCIA = sqrt(worldWidth * worldWidth + worldHeight * worldHeight);
  PVector direcao = new PVector();
  float distancia = 0f;
  Player player;
  Entity alvo;

  @Override
  void update(float deltaTime) {
    if (player == null) {
      player = (Player) entidades.stream().filter(e -> e instanceof Player).findFirst().orElse(null);
    }
    
    alvo = null;
    
    ArrayList<Pacote> pacotes = new ArrayList<Pacote>();
    
    transform.position.x = camera.transform.position.x;
    transform.position.y = camera.transform.position.y;
    
    for (Entity entity : entidades) {
      if (entity instanceof Pacote) {
        pacotes.add((Pacote) entity);
      }
    }
    float menorDistancia = Float.POSITIVE_INFINITY;
    float anguloParaAlvo = 0;

    if (!player.estaLotado()) {
      Pacote pacoteMaisProximo = null;
    
      for (Pacote pacote : pacotes) {
        float distanciaAtePacote = transform.position.dist(pacote.transform.position);
  
        if (distanciaAtePacote < menorDistancia) {
          pacoteMaisProximo = pacote;
          menorDistancia = distanciaAtePacote;
        }
      }
      
      if (pacoteMaisProximo == null) return;

      alvo = pacoteMaisProximo;
      anguloParaAlvo = PVector.sub(pacoteMaisProximo.transform.position, transform.position).heading();
    } else {
      ZonaDeDespacho zonaDeDespacho = (ZonaDeDespacho) entidades.stream().filter(e -> e instanceof ZonaDeDespacho).findFirst().orElse(null);
      
      alvo = zonaDeDespacho;
      menorDistancia = transform.position.dist(zonaDeDespacho.transform.position);
      anguloParaAlvo = PVector.sub(zonaDeDespacho.transform.position, transform.position).heading();
    }
    
    
    direcao = PVector.fromAngle(anguloParaAlvo);
    distancia = menorDistancia;
  }
  
  @Override
  void render() {
    if (alvo == null) return;
    
    float[] corDoGps = alvo instanceof ZonaDeDespacho ? new float[] { 255, 255, 0 } : new float[] { 0, 255, 255 };

    noFill();
    stroke(corDoGps[0], corDoGps[1], corDoGps[2]);
    arc(0, 0, 100, 100, direcao.heading() - radians(22.5), direcao.heading() + radians(22.5));
    
    pushMatrix();
      PVector ponteiro = direcao.copy().setMag(53);
      translate(ponteiro.x, ponteiro.y);
      rotate(direcao.heading());
      
      pushStyle();
        fill(corDoGps[0], corDoGps[1], corDoGps[2]);
        noStroke();
        regularPolygon(0, 0, 6, 3);
      popStyle();
    popMatrix();
  }
}
