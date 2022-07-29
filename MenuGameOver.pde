class MenuGameOver extends Entity {
  String[] menuItems = {
    "Recomeçar",
    "Sair"
  };
  float menuItemWidth = 200;
  float menuItemHeight = 70;
  float menuItemMargin = 30;
  
  int menuItemSelecionado = -1;
  int pacotesEntregues = 0;
  
  @Override
  void update(float deltaTime) {
    Player player = (Player) entidades.stream().filter(e -> e instanceof Player).findFirst().orElse(null);
    
    if (player != null) {
      println(player.pacotesEntregues);
      pacotesEntregues = player.pacotesEntregues;
      player.destroy();
    }
    
    transform.position.x = camera.transform.position.x;
    transform.position.y = camera.transform.position.y;
    menuItemSelecionado = -1;
    
    if (gameState != GameState.GAME_OVER) return;
    
    for (int i = 0; i < menuItems.length; i++) {
      if (mouseX <= width / 2 - menuItemWidth / 2 || mouseX >= width / 2 + menuItemWidth / 2) {
        return;
      }
      
      if (mouseY >= (height / 2 - menuItemHeight / 2) + i * (menuItemMargin + menuItemHeight)
       && mouseY <= (height / 2 - menuItemHeight / 2) + i * (menuItemMargin + menuItemHeight) + menuItemHeight) {
        menuItemSelecionado = i;
      }
    }    
  }
  
  @Override
  void aoClicarComMouse() {
    if (mouseX <= width / 2 - menuItemWidth / 2 || mouseX >= width / 2 + menuItemWidth / 2) {
      return;
    }
    
    if (mouseY >= (height / 2 - menuItemHeight / 2)
     && mouseY <= (height / 2 - menuItemHeight / 2) + menuItemHeight) {
      aoClicarNoBotaoDeComecar();
    }
    
    if (mouseY >= (height / 2 - menuItemHeight / 2) + menuItemMargin + menuItemHeight
     && mouseY <= (height / 2 - menuItemHeight / 2) + menuItemMargin + 2 * menuItemHeight + menuItemHeight) {
      aoClicarNoBotaoDeSair();
    }
  }
  
  @Override
  void render() {
    noStroke();
    fill(0, 0, 0, 180);
    rectMode(CENTER);
    rect(0, 0, width, height);
    
    // Renderiza "Fim de jogo"
    pushMatrix();
      translate(0, -200);
      
      textSize(48);
      textAlign(CENTER, CENTER);
      
      noStroke();
      fill(255);
      
      text("Fim de jogo", 0, 0);
    popMatrix();

    // Renderiza total de pacotes entregues
    pushMatrix();
      translate(0, -150);
      
      textSize(24);
      textAlign(CENTER, CENTER);
      
      noStroke();
      fill(255);
      
      text("Você entregou " + pacotesEntregues + (pacotesEntregues == 1 ? " pacote" : " pacotes"), 0, 0);
    popMatrix();
    
    // Renderiza botões do menu
    pushMatrix();
      strokeWeight(3);
      textAlign(CENTER, CENTER);
      textSize(24);
      for (int i = 0; i < menuItems.length; i++) {
        translate(0, i * (menuItemMargin + menuItemHeight));
        
        if (menuItemSelecionado == i) fill(255); 
        else noFill();
        
        stroke(255);
        rect(0, 0, menuItemWidth, menuItemHeight);
        
        if (menuItemSelecionado == i) fill(0);
        else fill(255);
        
        noStroke();
        text(menuItems[i].toUpperCase(), 0, 0);
      }
    popMatrix();
  }
  
  private void aoClicarNoBotaoDeComecar() {
    gameState = GameState.MENU;

    destroy();
    new MenuPrincipal().create();
  }
  
  private void aoClicarNoBotaoDeSair() {
    exit();
  }
}
