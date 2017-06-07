class Border {

  Body border;

  float w, h;

  Border(float x, float y, float iw, float ih) {
    w = iw;
    h = ih;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.STATIC;
    border = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();

    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
    border.createFixture(ps, 1);
  }

  void display() {
    rectMode(CENTER);
    fill(0);
    Vec2 pos = box2d.getBodyPixelCoord(border);
    rect(pos.x, pos.y, w, h);
  }
}