World world;
Camera camera;
ArrayList<Entity> entidadesParaCriar;
ArrayList<Entity> entidadesParaRemover;
ArrayList<Entity> entidades;
float lastUpdateMillis = 0;
int worldWidth = 3840;
int worldHeight = 2160;
boolean drawAABB = false;
GameState gameState = GameState.MENU;

void keyPressed() {
  if (key == 'w' || key == 'W') PressedKeys.W = true;
  if (key == 'a' || key == 'A') PressedKeys.A = true;
  if (key == 's' || key == 'S') PressedKeys.S = true;
  if (key == 'd' || key == 'D') PressedKeys.D = true;
  if (key == 'c' || key == 'C') PressedKeys.C = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') PressedKeys.W = false;
  if (key == 'a' || key == 'A') PressedKeys.A = false;
  if (key == 's' || key == 'S') PressedKeys.S = false;
  if (key == 'd' || key == 'D') PressedKeys.D = false;
  if (key == 'c' || key == 'C') PressedKeys.C = false;
}

void mousePressed() {
  for (Entity entity : entidades) {
    entity.aoClicarComMouse();
  }
}

void setup() {
  size(1280, 720, P2D);
  world = new World();
  camera = new Camera(new PVector(worldWidth / 2, worldHeight / 2), width, height);
  entidadesParaCriar = new ArrayList<Entity>();
  entidadesParaRemover = new ArrayList<Entity>();
  entidades = new ArrayList<Entity>();
  lastUpdateMillis = millis();
  
  entidades.add(new PacoteSpawner());
  entidades.add(new ZonaDeDespacho());
  entidades.add(new MenuPrincipal());
}

void update() {
  float currentTime = millis();
  float deltaTime = (currentTime - lastUpdateMillis) / 1000;
  lastUpdateMillis = currentTime;
  
  if (PressedKeys.C) {
    drawAABB = true;
  } else {
    drawAABB = false;
  }
  
  for (Entity entity : entidadesParaRemover) {
     entidades.remove(entity);
  }
  
  for (int i = entidades.size() - 1; i >= 0; i--) {
    if (entidades.get(i).destroyed)
      entidades.remove(i);
  }
  
  for (int i = entidadesParaCriar.size() - 1; i >= 0; i--) {
    entidades.add(entidadesParaCriar.get(i));
    entidadesParaCriar.remove(i);
  }
  
  for (Entity entidade : entidades) {
    entidade.updateSelfAndChildren(deltaTime);
    
    if (!entidade.usaColisor) continue;
    
    for (Entity outra : entidades) {
      if (entidade == outra) continue;
      if (!outra.usaColisor) continue;
      
      if (DetectorDeColisao.checaAABBcomAABB(entidade.getBoundingBox(), outra.getBoundingBox())) {
        entidade.aoColidirCom(outra);
      }
    }
  }
  
  world.update(deltaTime);
}

void draw() {
  clear();
  update();
  translate(world.transform.position.x, world.transform.position.y);
  rotate(camera.transform.rotation);
  
  world.render();
  
  for (Entity entidade : entidades) {
    entidade.setMatrixAndDraw();
  }
}

enum GameState {
  MENU,
  GAMEPLAY,
  GAME_OVER
}

// Funções auxiliares
static class PressedKeys {
  static boolean W = false;
  static boolean A = false;
  static boolean S = false;
  static boolean D = false;
  static boolean C = false;
}

void regularPolygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
