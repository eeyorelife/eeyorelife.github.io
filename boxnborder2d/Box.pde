class Box {

  Body box;

  float w, h;

  Box(float x, float y, float iw, float ih) {
    w = iw;
    h = ih;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.DYNAMIC;
    box = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Parameters that affect physics1    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    box.createFixture(fd);
  }

  void display() {
    rectMode(CENTER);
    fill(200);
    Vec2 pos = box2d.getBodyPixelCoord(box);
    rect(pos.x, pos.y, w, h);
  }
}