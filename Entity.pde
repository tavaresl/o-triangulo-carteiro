class Entity {
  final Transform transform = new Transform();
  final ArrayList<Entity> children = new ArrayList<Entity>();
  Entity parent = null;
  boolean destroyed = false;
  boolean usaColisor = false;
  
  final void setMatrixAndDraw() {
    pushMatrix();      
      translate(transform.position.x, transform.position.y);
      scale(transform.scale);
      rotate(transform.rotation);
      
      pushStyle();
      render();
      
      for (Entity child : children) {
        child.setMatrixAndDraw();
      }
      popStyle();
    popMatrix();
      
      
    if (drawAABB) {
      AABB aabb = getBoundingBox();

      pushStyle();
        noFill();
        stroke(0, 255, 0);
        beginShape();
          vertex(aabb.topLeftPosition.x, aabb.topLeftPosition.y);
          vertex(aabb.topRightPosition.x, aabb.topRightPosition.y);
          vertex(aabb.bottomRightPosition.x, aabb.bottomRightPosition.y);
          vertex(aabb.bottomLeftPosition.x, aabb.bottomLeftPosition.y);
        endShape(CLOSE);
      popStyle();
    }
  }
  
  final void create() {
    entidadesParaCriar.add(this);
  }

  final void destroy() {
    destroyed = true;
  }
  
  final void updateSelfAndChildren(float deltaTime) {
    update(deltaTime);
    
    for (Entity child : children) {
      child.updateSelfAndChildren(deltaTime);
    }
  }
  
  final void bindTo(Entity parent) {
    if (this.parent != null) {
      this.parent.release(this);
    } else if (entidades.indexOf(this) >= 0) {
      entidadesParaRemover.add(this);
    }
    
    this.parent = parent;
    parent.children.add(this);
    
    transform.position.sub(parent.transform.position);
  }
  
  final void release(Entity child) {
    for (int i = children.size() - 1; i >= 0; i--) {
      if (children.get(i) == child) {
        children.get(i).parent = null;
        children.remove(i);
        break;
      }
    }
  }
  
  AABB getBoundingBox() { return new AABB(); }
  void update(float deltaTime) { }
  void render() { }
  void aoColidirCom(Entity outro) { }
}

final class Transform {
  PVector position;
  float rotation;
  float scale;
  
  Transform() {
    position = new PVector();
    scale = 1;
    rotation = 0;
  }
}
