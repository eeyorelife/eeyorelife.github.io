Ok, this is very quickly going to get very messy. In fact, it is already very messy. So let's make a couple of classes and do it all over again:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

Box box;
Boundary boundary;

void setup() {
  size(600, 400);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  box = new Box(width/2, height/2, 16, 16);
  boundary = new Boundary(width/2, height-8, width, 16);
}

void draw() {
  background(50);
  box2d.step();

  box.display();
  boundary.display();
}

class Boundary {

  Body boundary;

  float w, h;

  Boundary(float x, float y, float iw, float ih) {
    w = iw;
    h = ih;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.STATIC;
    boundary = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();

    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
    boundary.createFixture(ps, 1);
  }

  void display() {
    rectMode(CENTER);
    fill(0);
    Vec2 pos = box2d.getBodyPixelCoord(boundary);
    rect(pos.x, pos.y, w, h);
  }
}


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
    box.createFixture(ps, 1);
  }

  void display() {
    rectMode(CENTER);
    fill(200);
    Vec2 pos = box2d.getBodyPixelCoord(box);
    rect(pos.x, pos.y, w, h);
  }
}
```

Ok, nothing really changed, except that we now have two classes. How is that better? Well, making an instance of a class is much easier and faster to do than to hard code every single object in the world. So that's the basics of Box2D. Happy coding!
