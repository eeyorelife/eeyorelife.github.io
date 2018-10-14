### The shape
What do we need to define a shape? We need to know what kind of shape we want to create and it's size. First, we make width and height variables like we are used to in Processing: `float w = 16, h = 16;`. Then we use the ´PolygonShape()´ class to create a new shape: `PolygonShape ps = new PolygonShape();` And then we set it as a box: `ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));`. Okay, so we remembered to use `scalarPixelsToWorld` to convert size from Processing to Box2D. But why are we dividing width and height by 2? Because Box2D defines width as the distance from the center to the edge. Almost like a radius in a circle. Don't ask me how that makes sense. So the variable that hold the width will be half of the actual width of the body. 

Now we have a body(soul) and a shape and they are beautiful! The only problem is that they are separate. They don't know each other yet. We need to _join_ them with a _fixture_. And that could get very comlicated, but _fortunately_ Box2D has made an option to just go with a default fixture. So we don't have to worry too much about it. Here is the easy way to create a fixture:  `body.createFixture(ps,1);` Throwing it all together again:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body;

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
```

Lok at that! We have a body, we have a shape, we have a fixture! [But the screen is _still_ empty!](Display)
