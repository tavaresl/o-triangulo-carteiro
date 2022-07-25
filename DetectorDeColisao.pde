static class DetectorDeColisao {
  static boolean checaAABBcomAABB(AABB colisor1, AABB colisor2) {
    return (
      colisor1.topLeftPosition.x    <= colisor2.topRightPosition.x   &&
      colisor1.topRightPosition.x   >= colisor2.topLeftPosition.x    &&
      colisor1.topLeftPosition.y    <= colisor2.bottomLeftPosition.y &&
      colisor1.bottomLeftPosition.y >= colisor2.topLeftPosition.y
    );
  }  
}
