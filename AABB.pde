class AABB {
  PVector topLeftPosition;
  PVector topRightPosition;
  PVector bottomRightPosition;
  PVector bottomLeftPosition;
  
  AABB() {
    topLeftPosition = new PVector();
    topRightPosition = new PVector();
    bottomRightPosition = new PVector();
    bottomLeftPosition = new PVector();
    
  }
  
  AABB(PVector tl, PVector tr, PVector br, PVector bl) {
    topLeftPosition = tl.copy();
    topRightPosition = tr.copy();
    bottomRightPosition = br.copy();
    bottomLeftPosition = bl.copy();
  }
  
  @Override
  String toString() {
    return "[" + topLeftPosition + "," + topRightPosition + "," + bottomRightPosition + "," + bottomLeftPosition + "]";
  }
}
