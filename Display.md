###Displaying the objects

Since we have handed over the job of handling the information and calculation of the object to Box2D, we have to _retrieve_ them  from Box2D when we have need for them. Here is how you ask for coordinates of the body we have just created: `Vec2 pos = box2d.getBodyPixelCoord(body);`. And then we can use that information to draw it: `rect(pos.x, pos.y, w,h);` But it won't move yet. It won't react to any _forces_. It's going to stand completely still until we start _moving through time_. That's right, we have to step through _time_: `box2d.step();` Oh, and we will have to change the rectMode: `rectMode(CENTER);`, so that we are drawing the rectangle at the correct position.

Now, we can see it move:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body;

float w = 16, h = 16;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));
  bd.type = BodyType.DYNAMIC;
  
  body = box2d.createBody(bd);
  
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
  
  body.createFixture(ps,1);
}

void draw(){
  box2d.step();
  rectMode(CENTER);
  Vec2 pos = box2d.getBodyPixelCoord(body);
  rect(pos.x, pos.y, w,h);
}
```
WE MADE IT! We have a body, a shape, a fixture, and we can see it! It's a box! That was a lot of work just for a little rectangle falling off the screen. Let's make another one! But lets try to make a static boundary on the bottom of the screen:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body box;
Body boundary;

float w = 16, h = 16;
float w1; //I want this to be the width of the screen, so we have to assign the value in setup()

void setup() {
  size(600, 400); //let's give ourselves some more space
  w1 = width;

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2, height/2));
  bd.type = BodyType.DYNAMIC;
  box = box2d.createBody(bd);
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
  box.createFixture(ps, 1);


  BodyDef bd1 = new BodyDef();
  bd1.position.set(box2d.coordPixelsToWorld(width/2, height-(h/2))); //I want it to be at the bottom.
  bd1.type = BodyType.STATIC; //This one needs to be static
  boundary = box2d.createBody(bd1);
  PolygonShape ps1 = new PolygonShape();
  ps1.setAsBox(box2d.scalarPixelsToWorld(w1/2), box2d.scalarPixelsToWorld(h/2)); //remember to use the right variable for width
  boundary.createFixture(ps1, 1);
}

void draw() {
  box2d.step();
  rectMode(CENTER);
  Vec2 pos = box2d.getBodyPixelCoord(box);
  rect(pos.x, pos.y, w, h);
  
  
  Vec2 pos1 = box2d.getBodyPixelCoord(boundary);
  rect(pos1.x, pos1.y, w1, h);
}
```

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

Wow! It does exactly the same! That's great, right?wait, how is that better? Well, making an instance of a class is much easier and faster to do than to hard code every single object in the world (_Literally_). So that's the basics of Box2D. Happy coding!
