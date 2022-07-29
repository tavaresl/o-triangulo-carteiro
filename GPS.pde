class GPS extends Entity {
  final float MAIOR_DISTANCIA = sqrt(worldWidth * worldWidth + worldHeight * worldHeight);
  PVector direcaoPacote = new PVector();
  PVector direcaoZonaDeDespacho = new PVector();
  boolean renderizaSetaPacote = false;
  boolean renderizaSetaZona = false;
  
  Pacote pacoteAlvo;
  ZonaDeDespacho zonaDeDespacho;
  Entity alvo;

  @Override
  void update(float deltaTime) {
    ArrayList<Pacote> pacotes = new ArrayList<Pacote>();
    renderizaSetaPacote = false;
    renderizaSetaZona = false;
    
    for (Entity entity : entidades) {
      if (entity instanceof Pacote) {
        pacotes.add((Pacote) entity);
      }
    }
    
    Player player = (Player) parent;

    if (!player.estaLotado()) {
      renderizaSetaPacote = true;
      alvo = null;
      Pacote pacoteMaisProximo = null;
      float menorDistancia = Float.POSITIVE_INFINITY;
      float anguloParaPacote = 0;
      
      for (Pacote pacote : pacotes) {
        float distanciaAtePacote = parent.transform.position.dist(pacote.transform.position);
        
        if (distanciaAtePacote < menorDistancia) {
          pacoteMaisProximo = pacote;
          menorDistancia = distanciaAtePacote;
        }
      }
      
      if (pacoteMaisProximo == null) return;

      alvo = pacoteMaisProximo;
      anguloParaPacote = PVector.sub(pacoteMaisProximo.transform.position, parent.transform.position).heading();
      direcaoPacote = PVector.fromAngle(anguloParaPacote).rotate(-parent.transform.rotation);
    }

    ZonaDeDespacho zonaDeDespacho = (ZonaDeDespacho) entidades.stream().filter(e -> e instanceof ZonaDeDespacho).findFirst().orElse(null);
    
    if (zonaDeDespacho != null && player.pacotesColetados > 0) {
      renderizaSetaZona = true;
      float anguloParaZona = 0;
      anguloParaZona = PVector.sub(zonaDeDespacho.transform.position, parent.transform.position).heading();
      direcaoZonaDeDespacho = PVector.fromAngle(anguloParaZona).rotate(-parent.transform.rotation);
    }
  }
  
  @Override
  void render() {
    float[] corDoGpsPacote = new float[] { 0, 255, 255 };
    float[] corDoGpsZonaDeDespacho = new float[] { 255, 255, 0 };

    noFill();
    
    if (renderizaSetaPacote) {
      stroke(corDoGpsPacote[0], corDoGpsPacote[1], corDoGpsPacote[2]);
      arc(0, 0, 100, 100, direcaoPacote.heading() - radians(22.5), direcaoPacote.heading() + radians(22.5));
      
      pushMatrix();
        PVector ponteiro = direcaoPacote.copy().setMag(53);
        translate(ponteiro.x, ponteiro.y);
        rotate(direcaoPacote.heading());
        
        pushStyle();
          fill(corDoGpsPacote[0], corDoGpsPacote[1], corDoGpsPacote[2]);
          noStroke();
          regularPolygon(0, 0, 6, 3);
        popStyle();
      popMatrix();
    }
    
    if (renderizaSetaZona) {
      stroke(corDoGpsZonaDeDespacho[0], corDoGpsZonaDeDespacho[1], corDoGpsZonaDeDespacho[2]);
      arc(0, 0, 160, 160, direcaoZonaDeDespacho.heading() - radians(22.5), direcaoZonaDeDespacho.heading() + radians(22.5));
      
      pushMatrix();
        PVector ponteiroZona = direcaoZonaDeDespacho.copy().setMag(83);
        translate(ponteiroZona.x, ponteiroZona.y);
        rotate(direcaoZonaDeDespacho.heading());
        
        pushStyle();
          fill(corDoGpsZonaDeDespacho[0], corDoGpsZonaDeDespacho[1], corDoGpsZonaDeDespacho[2]);
          noStroke();
          regularPolygon(0, 0, 6, 3);
        popStyle();
      popMatrix();
    }
  }
}
