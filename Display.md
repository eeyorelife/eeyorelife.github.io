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
WE MADE IT! We have a body, a shape, a fixture, and we can see it! It's a box! That was a lot of work just for a little rectangle falling off the screen. Let's make another one!
